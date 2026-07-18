#!/usr/bin/env python3
"""Lightweight source guard for the project's Clean Architecture boundaries."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIB = ROOT / "lib"
FEATURES = LIB / "features"

FORBIDDEN_DOMAIN_IMPORTS = (
    "package:flutter",
    "package:super_",
    "/presentation/",
    "/data/",
    "design_system",
)

PRESENTATION_MODEL_ALLOWLIST = {
    "NavigationItem",
    "NavigationGroup",
    "SettingsNavigationItem",
    "SettingsNavigationSection",
}

PRESENTATION_SUFFIX_ALLOWLIST = (
    "Screen",
    "Page",
    "View",
    "Widget",
    "State",
    "Event",
    "Bloc",
    "Cubit",
    "Controller",
    "Painter",
    "Delegate",
)


def imports(path: Path) -> list[str]:
    return re.findall(r"(?m)^\s*import\s+'([^']+)'", path.read_text(encoding="utf-8"))


def local_directives(path: Path) -> list[str]:
    return re.findall(
        r"(?m)^\s*(?:import|export|part)\s+'([^']+)'",
        path.read_text(encoding="utf-8"),
    )


def fail(errors: list[str], message: str) -> None:
    errors.append(message)


def main() -> int:
    errors: list[str] = []
    dart_files = sorted(LIB.rglob("*.dart"))

    for path in dart_files:
        rel = path.relative_to(ROOT).as_posix()
        source_imports = imports(path)

        if "/domain/" in rel:
            for uri in source_imports:
                if any(token in uri for token in FORBIDDEN_DOMAIN_IMPORTS):
                    fail(errors, f"Domain dependency violation: {rel} imports {uri}")

            source = path.read_text(encoding="utf-8")
            for match in re.finditer(r"(?m)^class\s+(\w+)(?:\s+extends\s+\w+)?\s*\{", source):
                class_name = match.group(1)
                body_start = match.end()
                body_end = source.find("\n}", body_start)
                body = source[body_start : body_end if body_end >= 0 else len(source)]
                mutable_fields = re.findall(
                    r"(?m)^\s*(?!static\b)(?!final\b)(?!const\b)(?!late\s+final\b)(?:[A-Z_a-z][\w<>?, ]*)\s+(\w+)\s*;",
                    body,
                )
                if mutable_fields:
                    fail(errors, f"Mutable Domain fields in {rel}:{class_name}: {mutable_fields}")

        if "/data/" in rel:
            for uri in source_imports:
                if "/presentation/" in uri:
                    fail(errors, f"Data -> Presentation violation: {rel} imports {uri}")
                if uri.startswith("package:flutter"):
                    fail(errors, f"Flutter dependency in Data: {rel} imports {uri}")

        if "/presentation/" in rel:
            for uri in source_imports:
                if "/data/" in uri:
                    fail(errors, f"Presentation -> Data violation: {rel} imports {uri}")

            source = path.read_text(encoding="utf-8")
            for declaration in re.finditer(
                r"(?m)^\s*(?:abstract\s+|sealed\s+|final\s+|base\s+|interface\s+)?class\s+(\w+)(?:\s+extends\s+([^\{\n]+))?",
                source,
            ):
                class_name = declaration.group(1)
                base_type = (declaration.group(2) or "").strip()
                if class_name.startswith("_"):
                    continue
                if class_name in PRESENTATION_MODEL_ALLOWLIST:
                    continue
                if class_name.endswith(PRESENTATION_SUFFIX_ALLOWLIST):
                    continue
                if any(token in base_type for token in ("Widget", "State<", "Event", "Bloc", "Cubit", "Controller", "Painter", "Delegate", "Notifier")):
                    continue
                fail(errors, f"Potential business model declared in Presentation: {rel}:{class_name}")

        for uri in local_directives(path):
            if uri.startswith(("dart:", "package:")):
                continue
            if not (path.parent / uri).resolve().exists():
                fail(errors, f"Missing local directive target: {rel} -> {uri}")

    screen_count = 0
    for path in FEATURES.glob("**/presentation/pages/*.dart"):
        source = path.read_text(encoding="utf-8")
        for match in re.finditer(
            r"class\s+(\w+Screen)\s+extends\s+(?:StatelessWidget|StatefulWidget)",
            source,
        ):
            screen_count += 1
            name = match.group(1)
            constructor = re.search(rf"(?:const\s+)?{name}\s*\((.*?)\)", source, re.S)
            if constructor is None:
                fail(errors, f"Public screen has no constructor: {path.relative_to(ROOT)}:{name}")
            elif "super.key" not in constructor.group(1) and "Key? key" not in constructor.group(1):
                fail(errors, f"Reusable screen has no key parameter: {path.relative_to(ROOT)}:{name}")

    if errors:
        print("Clean Architecture check failed:\n")
        for error in errors:
            print(f"- {error}")
        return 1

    domain_entities = sum(
        len(re.findall(r"(?m)^class\s+\w+", path.read_text(encoding="utf-8")))
        for path in FEATURES.glob("**/domain/entities/*.dart")
    )
    print(
        "Clean Architecture check passed: "
        f"{len(dart_files)} Dart files, {domain_entities} domain entity classes, "
        f"{screen_count} reusable screens."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
