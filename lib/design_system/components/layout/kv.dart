// Deprecated compatibility shim.
// New code should import `key_value_row.dart` and use [KeyValueRow].

import 'key_value_row.dart';

export 'key_value_row.dart';

/// Deprecated alias for [KeyValueRow].
@Deprecated('Use KeyValueRow instead.')
class KV extends KeyValueRow {
  const KV(
    super.k,
    super.v, {
    super.key,
    super.mono,
    super.ar,
  });
}
