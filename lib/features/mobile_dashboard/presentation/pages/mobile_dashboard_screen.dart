// ============================================================
// VIEW — Mobile Dashboard v2 (ports Mobile Dashboard.html)
// Exact-style rebuild: workspace header · good morning · domain
// tabs · view/currency/period row · metric cards / chart view ·
// quick actions · recent ops · needs attention · FAB · bottom nav.
// Dark + English (the .html default tweaks). Self-contained.
// ============================================================

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/load_status.dart';
import '../../../../design_system/kit.dart';
import '../../../../workspace/presentation/bloc/tenant_cubit.dart';
import '../bloc/mobile_dashboard_cubit.dart';
import '../../data/datasources/mobile_dashboard_data.dart';

class MobileDashboardScreen extends StatefulWidget {
  const MobileDashboardScreen({super.key});
  @override
  State<MobileDashboardScreen> createState() => _MobileDashboardScreenState();
}

class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
  // Dashboard view state lives in MobileDashboardCubit; these getters read it.
  late final MobileDashboardCubit _dash;
  String get _tab => _dash.state.tab;
  String get _cur => _dash.state.cur;
  String get _period => _dash.state.period;
  String get _view => _dash.state.view;
  String? get _chartMetric => _dash.state.chartMetric;
  bool get _loading => _dash.state.status.isLoading;
  // Active tenant id mirrored from TenantCubit (persists across the tenant
  // scope rebuild that a switch triggers). `_ws` is derived from it.
  String _activeTenantId = '9';
  // Ephemeral overlay state — pure UI, stays local.
  bool _wsOpen = false;
  bool _drawerOpen = false;
  bool _online = true;
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _dash = MobileDashboardCubit();
  }

  MdTab get _cfg => mdTabs.firstWhere((t) => t.id == _tab);

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check_rounded, size: 15, color: SuperMaterialThemeData.of(context).superTheme.bg), const SizedBox(width: 8), Text(msg, style: TextStyle(color: SuperMaterialThemeData.of(context).superTheme.bg, fontWeight: FontWeight.w600, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))]),
        backgroundColor: SuperMaterialThemeData.of(context).superTheme.fg1, behavior: SnackBarBehavior.floating, duration: const Duration(milliseconds: 1600),
        shape: const StadiumBorder(), width: 280,
      ));
  }

  Future<void> _refresh() => _dash.refresh();

  // The displayed workspace is whichever catalog entry maps to the active
  // tenant; falls back to the first. Tenant id is parsed from the "Tenant N"
  // tag so the demo's per-tenant currency factor still applies.
  MdWorkspace get _ws => mdWorkspaces.firstWhere(
        (w) => _tenantIdOf(w) == _activeTenantId,
        orElse: () => mdWorkspaces[0],
      );
  String _tenantIdOf(MdWorkspace w) => w.tag.split(' ').last;

  void _switchWorkspace(MdWorkspace w) {
    // Real, isolated tenant switch: TenantCubit.switchTo changes the
    // ValueKey(tenantId) on TenantScope, tearing down this tenant's scope
    // and rebuilding fresh. _ws then reflects the new active tenant.
    setState(() => _wsOpen = false);
    context.read<TenantCubit>().switchTo(_tenantIdOf(w));
    if (_scrollCtrl.hasClients) _scrollCtrl.jumpTo(0);
    _refresh();
  }

  double _cardVal(MdCard c) => (c.val[_cur] ?? 0) * _ws.factor;
  double _opAmt(MdOp o) => (o.amt[_cur] ?? 0) * _ws.factor;

  @override
  void dispose() {
    _dash.close();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mirror the active tenant so `_ws` (and its factor) follow the real
    // TenantCubit selection — it survives the scope rebuild a switch causes.
    _activeTenantId = context.watch<TenantCubit>().state.activeTenantId ?? _activeTenantId;
    return BlocProvider<MobileDashboardCubit>.value(
      value: _dash,
      child: BlocBuilder<MobileDashboardCubit, MobileDashboardState>(
        builder: (context, _) => Scaffold(
      backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top + 64),
        child: _appBar(),
      ),
      body: Stack(children: [
        Column(children: [
          if (!_online) _offlineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              color: SuperMaterialThemeData.of(context).colorScheme.primary,
              backgroundColor: SuperMaterialThemeData.of(context).superTheme.surface,
              child: ListView(
                controller: _scrollCtrl,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 120),
                children: [
                  _title(),
                  const SizedBox(height: 16),
                  _domainTabs(),
                  const SizedBox(height: 14),
                  _controlsRow(),
                  const SizedBox(height: 12),
                  if (_view == 'cards') _cardsGrid() else _chartView(),
                  const SizedBox(height: 24),
                  _quickActions(),
                  const SizedBox(height: 24),
                  _recentOps(),
                  const SizedBox(height: 24),
                  _attention(),
                ],
              ),
            ),
          ),
        ]),
        _bottomNav(),
        _fab(),
        if (_wsOpen) _wsPopup(),
        _drawer(),
      ]),
        ),
      ),
    );
  }

  // ── app bar (workspace selector · bell · menu) ──
  Widget _appBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 14, 18, 12),
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg.withAlpha(0xE6), border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
          child: Row(children: [
            Expanded(
              child: _Press(
                onTap: () => setState(() => _wsOpen = !_wsOpen),
                child: Row(children: [
                  Container(width: 38, height: 38, alignment: Alignment.center, decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x29), borderRadius: BorderRadius.circular(10)), child: Icon(MIcons.of('grid'), size: 19, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(_ws.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 14, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                    Text(_ws.tag, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ])),
                  AnimatedRotation(turns: _wsOpen ? 0.5 : 0, duration: const Duration(milliseconds: 200), child: Icon(MIcons.of('chevD'), size: 15, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            _iconBox('bell', () => _toast('Notifications'), badge: '8'),
            const SizedBox(width: 8),
            _iconBox('menu', () => setState(() => _drawerOpen = true)),
          ]),
        ),
      ),
    );
  }

  Widget _offlineBanner() {
    return Container(
      width: double.infinity,
      color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.tertiary, 0x29),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      child: Row(children: [
        Icon(MIcons.of('ban'), size: 15, color: SuperMaterialThemeData.of(context).colorScheme.tertiary),
        const SizedBox(width: 8),
        Expanded(child: Text("You're offline — showing last-known data", style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).colorScheme.tertiary))),
      ]),
    );
  }

  Widget _iconBox(String icon, VoidCallback onTap, {String? badge}) {
    return _Press(
      onTap: onTap,
      child: Container(
        width: 38, height: 38, alignment: Alignment.center,
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
        child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          Icon(MIcons.of(icon), size: 18, color: SuperMaterialThemeData.of(context).superTheme.fg1),
          if (badge != null) Positioned(top: -8, right: -8, child: Container(
            constraints: const BoxConstraints(minWidth: 15), height: 15, alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).colorScheme.error, borderRadius: BorderRadius.circular(999), border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.bg, width: 1.5)),
            child: Text(badge, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)),
          )),
        ]),
      ),
    );
  }

  Widget _wsPopup() {
    return Positioned.fill(
      child: Stack(children: [
        GestureDetector(onTap: () => setState(() => _wsOpen = false), child: Container(color: Colors.transparent)),
        Positioned(
          top: MediaQuery.of(context).padding.top + 60, left: 18, right: 18,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(14), boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 28, offset: Offset(0, 12))]),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Padding(padding: EdgeInsets.fromLTRB(10, 8, 10, 6), child: Text('SWITCH WORKSPACE', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.8, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                for (final w in mdWorkspaces)
                  GestureDetector(
                    onTap: () => _switchWorkspace(w),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.all(10), constraints: const BoxConstraints(minHeight: 48),
                      decoration: BoxDecoration(color: w.id == _ws.id ? SuperMaterialThemeData.of(context).superTheme.hover : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                      child: Row(children: [
                        Container(width: 34, height: 34, alignment: Alignment.center, decoration: BoxDecoration(color: w.id == _ws.id ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.inputBg, borderRadius: BorderRadius.circular(9)), child: Text(w.name[0], style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 14, color: w.id == _ws.id ? Colors.white : SuperMaterialThemeData.of(context).superTheme.fg3))),
                        const SizedBox(width: 11),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(w.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                          Text(w.tag, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                        ])),
                        if (w.id == _ws.id) Icon(MIcons.of('check'), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
                      ]),
                    ),
                  ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  // ── side drawer (slides from start edge) ──
  Widget _drawer() {
    return IgnorePointer(
      ignoring: !_drawerOpen,
      child: AnimatedOpacity(
        opacity: _drawerOpen ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Stack(children: [
          GestureDetector(onTap: () => setState(() => _drawerOpen = false), child: Container(color: Colors.black.withOpacity(0.5))),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            top: 0, bottom: 0,
            left: _drawerOpen ? 0 : -300,
            width: 300,
            child: Material(
              color: SuperMaterialThemeData.of(context).superTheme.surface,
              child: Column(children: [
                // workspace header
                Container(
                  padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 18, 18, 16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  child: Row(children: [
                    Container(width: 42, height: 42, alignment: Alignment.center, decoration: BoxDecoration(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0x29), borderRadius: BorderRadius.circular(12)), child: Icon(MIcons.of('grid'), size: 20, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(_ws.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 15, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
                      Text(_ws.tag, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                    ])),
                  ]),
                ),
                // nav + preferences
                Expanded(child: ListView(padding: const EdgeInsets.all(10), children: [
                  for (final it in const [('Home', 'home'), ('Accounts', 'inbox'), ('Journal', 'doc'), ('Contacts', 'user'), ('Reports', 'poll'), ('Settings', 'dots')])
                    _drawerItem(it.$1, it.$2),
                  Container(margin: const EdgeInsets.symmetric(vertical: 8), height: 1, color: SuperMaterialThemeData.of(context).superTheme.border),
                  Padding(padding: EdgeInsets.fromLTRB(12, 2, 12, 6), child: Text('PREFERENCES', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.9, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
                  _drawerSeg('Connection', _online ? 0 : 1, const ['Online', 'Offline'], (i) => setState(() => _online = i == 0)),
                ])),
                // sign out
                Container(
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
                  padding: EdgeInsets.fromLTRB(10, 12, 10, MediaQuery.of(context).padding.bottom + 14),
                  child: _Press(
                    onTap: () { setState(() => _drawerOpen = false); _toast('Sign out'); },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 48), padding: const EdgeInsets.all(12),
                      child: Row(children: [
                        Icon(MIcons.of('ban'), size: 19, color: SuperMaterialThemeData.of(context).colorScheme.error),
                        const SizedBox(width: 12),
                        Text('Sign out', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).colorScheme.error)),
                      ]),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _drawerItem(String label, String icon) {
    final theme = SuperMaterialThemeData.of(context).superTheme;
    return _Press(
      onTap: () { setState(() => _drawerOpen = false); _toast(label); },
      child: Container(
        constraints: const BoxConstraints(minHeight: 48), padding: const EdgeInsets.all(12),
        child: Row(children: [
          Icon(MIcons.of(icon), size: 19, color: SuperMaterialThemeData.of(context).superTheme.fg2),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.fg1))),
          Icon(MIcons.of('chevR'), size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg4),
        ]),
      ),
    );
  }

  Widget _drawerSeg(String label, int value, List<String> options, ValueChanged<int> onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            for (int i = 0; i < options.length; i++)
              Expanded(child: GestureDetector(
                onTap: () => onChange(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150), constraints: const BoxConstraints(minHeight: 32), alignment: Alignment.center,
                  decoration: BoxDecoration(color: i == value ? SuperMaterialThemeData.of(context).colorScheme.primary : Colors.transparent, borderRadius: BorderRadius.circular(6)),
                  child: Text(options[i], style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: i == value ? FontWeight.w700 : FontWeight.w500, color: i == value ? Colors.white : SuperMaterialThemeData.of(context).superTheme.fg3)),
                ),
              )),
          ]),
        ),
      ]),
    );
  }

  Widget _title() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('GOOD MORNING', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 1.3, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
      SizedBox(height: 3),
      Text('Dashboard', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w800, fontSize: 28, letterSpacing: -0.8, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
    ]);
  }

  // ── domain tabs ──
  Widget _domainTabs() {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: Row(children: [
        for (final t in mdTabs) Expanded(child: _domainTab(t)),
      ]),
    );
  }

  Widget _domainTab(MdTab t) {
    final on = t.id == _tab;
    return GestureDetector(
      onTap: () => _dash.selectTab(t.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.fromLTRB(4, 10, 4, 12),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Center(child: Text(t.label, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 15, fontWeight: on ? FontWeight.w700 : FontWeight.w500, color: on ? SuperMaterialThemeData.of(context).superTheme.fg1 : SuperMaterialThemeData.of(context).superTheme.fg3))),
          AnimatedContainer(duration: const Duration(milliseconds: 200), margin: const EdgeInsets.symmetric(horizontal: 6), height: 2.5, decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).colorScheme.primary.withOpacity(on ? 1 : 0), borderRadius: BorderRadius.circular(3))),
        ]),
      ),
    );
  }

  // ── view popup + currency + period ──
  Widget _controlsRow() {
    return Row(children: [
      _viewToggle(),
      const SizedBox(width: 8),
      _currencyPopup(),
      const Spacer(),
      _periodSeg(),
    ]);
  }

  Widget _viewToggle() {
    final isChart = _view == 'chart';
    return GestureDetector(
      onTap: () => _dash.toggleView(),
      child: Container(
        height: 34, padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(MIcons.of(isChart ? 'poll' : 'grid'), size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg1),
          const SizedBox(width: 5),
          Text(isChart ? 'Charts' : 'Cards', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
        ]),
      ),
    );
  }

  Widget _currencyPopup() {
    return PopupMenuButton<String>(
      tooltip: 'Display currency',
      color: SuperMaterialThemeData.of(context).superTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.borderStrong)),
      onSelected: (v) => _dash.setCurrency(v),
      itemBuilder: (_) => [
        for (final c in mdCurrencies)
          PopupMenuItem<String>(value: c.$1, child: Row(children: [
            SizedBox(width: 42, child: Text(c.$1, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: c.$1 == _cur ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg1))),
            Expanded(child: Text(c.$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
            if (c.$1 == _cur) Icon(MIcons.of('check'), size: 16, color: SuperMaterialThemeData.of(context).colorScheme.primary),
          ])),
      ],
      child: Container(
        height: 34, padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(_cur, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          const SizedBox(width: 4),
          Icon(MIcons.of('chevD'), size: 14, color: SuperMaterialThemeData.of(context).superTheme.fg3),
        ]),
      ),
    );
  }

  Widget _periodSeg() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text('COMPARE', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.8, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          for (final p in const ['day', 'week', 'month']) _periodOpt(p),
        ]),
      ),
    ]);
  }

  Widget _periodOpt(String p) {
    final on = p == _period;
    final label = p == 'day' ? 'Day' : (p == 'week' ? 'Week' : 'Month');
    return GestureDetector(
      onTap: () => _dash.setPeriod(p),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150), constraints: const BoxConstraints(minHeight: 28),
        alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(color: on ? SuperMaterialThemeData.of(context).colorScheme.primary : Colors.transparent, borderRadius: BorderRadius.circular(6)),
        child: Text(label, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: on ? FontWeight.w700 : FontWeight.w500, color: on ? Colors.white : SuperMaterialThemeData.of(context).superTheme.fg3)),
      ),
    );
  }

  // ── metric cards grid ──
  Widget _cardsGrid() {
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.45,
      children: [for (final c in _cfg.cards) _metricCard(c)],
    );
  }

  Widget _metricCard(MdCard c) {
    final tr = c.trend[_period];
    final trColor = tr == null ? SuperMaterialThemeData.of(context).superTheme.fg4 : (tr.up ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error);
    return Stack(children: [
      Container(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 14, 14),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(14)),
        child: _loading
            ? const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                _Bone(w: 80, h: 9), SizedBox(height: 12), _Bone(w: 110, h: 20), SizedBox(height: 12), _Bone(w: 60, h: 9),
              ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(c.label.toUpperCase(), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 10.5, letterSpacing: 0.5, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
                const SizedBox(height: 9),
                Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                  Text(_cur, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, fontWeight: FontWeight.w500, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                  const SizedBox(width: 5),
                  Flexible(child: Text(mdNum(_cardVal(c)), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.8, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
                ]),
                const SizedBox(height: 9),
                SizedBox(height: 16, child: tr == null
                    ? Text('—', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, color: SuperMaterialThemeData.of(context).superTheme.fg4))
                    : Row(children: [
                        Text(tr.up ? '▲' : '▼', style: TextStyle(fontSize: 10, height: 1, color: trColor)),
                        const SizedBox(width: 5),
                        Text('${mdNum(tr.pct, decimals: 1)}%', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: FontWeight.w700, color: trColor)),
                      ])),
              ]),
      ),
      PositionedDirectional(start: 0, top: 14, bottom: 14, child: Container(width: 3, decoration: BoxDecoration(color: mdMarker(context, c.marker), borderRadius: BorderRadius.circular(3)))),
    ]);
  }

  // ── chart view ──
  Widget _chartView() {
    final cards = _cfg.cards;
    final sel = cards.firstWhere((c) => c.id == _chartMetric, orElse: () => cards.first);
    final tr = sel.trend[_period];
    final trColor = tr == null ? SuperMaterialThemeData.of(context).superTheme.fg4 : (tr.up ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error);
    final axis = mdAxis[_period]!;
    final maxVal = cards.map(_cardVal).fold(0.0, (a, b) => a > b ? a : b);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      // metric chips
      SizedBox(height: 32, child: ListView.separated(
        scrollDirection: Axis.horizontal, itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = cards[i];
          final on = c.id == sel.id;
          final mc = mdMarker(context, c.marker);
          return GestureDetector(
            onTap: () => _dash.setChartMetric(c.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: on ? superCoreTint(mc, 0x29) : SuperMaterialThemeData.of(context).superTheme.inputBg, border: Border.all(color: on ? Colors.transparent : SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(999)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 7, height: 7, decoration: BoxDecoration(color: mc, shape: BoxShape.circle)),
                const SizedBox(width: 7),
                Text(c.label, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: on ? FontWeight.w700 : FontWeight.w500, color: on ? mc : SuperMaterialThemeData.of(context).superTheme.fg3)),
              ]),
            ),
          );
        },
      )),
      const SizedBox(height: 14),
      // chart card
      Container(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 10),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Trend over · ${_period[0].toUpperCase()}${_period.substring(1)}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
              const SizedBox(height: 4),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                Text(_cur, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, fontWeight: FontWeight.w500, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
                const SizedBox(width: 5),
                Text(mdNum(_cardVal(sel)), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.8, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
              ]),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(color: superCoreTint(trColor, 0x24), borderRadius: BorderRadius.circular(999)),
              child: Text(tr == null ? '—' : '${tr.up ? '▲' : '▼'} ${mdNum(tr.pct, decimals: 1)}%', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: FontWeight.w700, color: trColor)),
            ),
          ]),
          const SizedBox(height: 6),
          SizedBox(height: 132, child: CustomPaint(painter: _TrendPainter(
            values: sel.series[_period]!.map((s) => s * _cardVal(sel)).toList(),
            color: mdMarker(context, sel.marker),
            axis: axis,
            borderColor: SuperMaterialThemeData.of(context).superTheme.border,
            surfaceColor: SuperMaterialThemeData.of(context).superTheme.surface,
            labelColor: SuperMaterialThemeData.of(context).superTheme.fg3,
            fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily,
          ))),
        ]),
      ),
      const SizedBox(height: 14),
      // breakdown bars
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Breakdown', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 13.5, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          const SizedBox(height: 1),
          Text('Share of this domain', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          const SizedBox(height: 13),
          for (final c in cards) _breakdownBar(c, maxVal),
        ]),
      ),
    ]);
  }

  Widget _breakdownBar(MdCard c, double max) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(child: Text(c.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg2))),
          const SizedBox(width: 10),
          Text('$_cur ${mdNum(_cardVal(c))}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w700, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(borderRadius: BorderRadius.circular(6), child: Stack(children: [
          Container(height: 8, color: SuperMaterialThemeData.of(context).superTheme.inputBg),
          LayoutBuilder(builder: (_, cns) => AnimatedContainer(
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut,
            height: 8, width: (max == 0 ? 0 : _cardVal(c) / max).clamp(0.04, 1.0) * cns.maxWidth,
            decoration: BoxDecoration(color: mdMarker(context, c.marker), borderRadius: BorderRadius.circular(6)),
          )),
        ])),
      ]),
    );
  }

  // ── quick actions ──
  Widget _quickActions() {
    final actions = _cfg.actions.take(7).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _secHead('Quick Actions', 'blue', trailing: _viewAllBtn(() => _openActions())),
      GridView.count(
        crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.82,
        children: [
          for (final a in actions) _actionTile(a.icon, a.label, SuperMaterialThemeData.of(context).colorScheme.primary, () => _toast('Opening ${a.label}')),
          _actionTile('dots', 'View all', SuperMaterialThemeData.of(context).superTheme.fg3, _openActions, isMore: true),
        ],
      ),
    ]);
  }

  Widget _actionTile(String icon, String label, Color color, VoidCallback onTap, {bool isMore = false}) {
    return _Press(
      onTap: onTap,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 46, height: 46, alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isMore ? Colors.transparent : superCoreTint(color, 0x21),
            border: isMore ? Border.all(color: SuperMaterialThemeData.of(context).superTheme.borderStrong, width: 1.5) : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(MIcons.of(icon), size: 20, color: color),
        ),
        const SizedBox(height: 7),
        Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg2)),
      ]),
    );
  }

  void _openActions() {
    showModalBottomSheet<void>(
      context: context, backgroundColor: SuperMaterialThemeData.of(context).superTheme.surface, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(18, 8, 18, MediaQuery.of(ctx).padding.bottom + 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 14), decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.borderStrong, borderRadius: BorderRadius.circular(4)))),
          Padding(padding: EdgeInsets.only(bottom: 12), child: Text('All Actions', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.headlineMedium?.fontFamily, fontWeight: FontWeight.w800, fontSize: 18, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
          for (final group in const [('create', 'Create new'), ('manage', 'Manage')])
            if (_cfg.actions.any((a) => a.group == group.$1)) ...[
              Padding(padding: const EdgeInsets.only(bottom: 10, top: 4), child: Text(group.$2.toUpperCase(), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.9, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
              GridView.count(
                crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.82,
                children: [for (final a in _cfg.actions.where((a) => a.group == group.$1)) _actionTile(a.icon, a.label, SuperMaterialThemeData.of(context).colorScheme.primary, () { Navigator.of(ctx).pop(); _toast('Opening ${a.label}'); })],
              ),
              const SizedBox(height: 18),
            ],
        ]),
      ),
    );
  }

  // ── recent operations ──
  Widget _recentOps() {
    final ops = _cfg.ops;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _secHead('Recent Operations', 'green', sub: 'Latest 5 in this domain', trailing: _viewAllBtn(() => _toast('Open journal'))),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(14)),
        child: Column(children: [
          if (_loading) for (int i = 0; i < 5; i++) _opSkeleton(i == 4)
          else for (int i = 0; i < ops.length; i++) _opRow(ops[i], i == ops.length - 1),
        ]),
      ),
    ]);
  }

  Widget _opRow(MdOp op, bool last) {
    final amtColor = op.isCredit ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error;
    final sign = op.isCredit ? '+' : '−';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text(op.desc, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1))),
          const SizedBox(width: 10),
          Text('$sign$_cur ${mdNum(_opAmt(op), decimals: 2)}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w700, color: amtColor)),
        ]),
        const SizedBox(height: 7),
        Row(children: [
          Text(op.ref, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
          const SizedBox(width: 8),
          _pill(op.type, mdTone(context, op.tone)),
          const Spacer(),
          Text(op.time, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
        ]),
      ]),
    );
  }

  Widget _opSkeleton(bool last) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
      child: const Column(children: [
        Row(children: [Expanded(child: _Bone(w: 160, h: 13)), SizedBox(width: 12), _Bone(w: 64, h: 13)]),
        SizedBox(height: 9),
        Row(children: [_Bone(w: 110, h: 9), Spacer(), _Bone(w: 40, h: 9)]),
      ]),
    );
  }

  // ── needs attention ──
  Widget _attention() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _secHead('Needs Attention', 'orange', trailing: Text('All domains', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).superTheme.fg3))),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.surface, border: Border.all(color: SuperMaterialThemeData.of(context).superTheme.border), borderRadius: BorderRadius.circular(14)),
        child: Column(children: [
          for (int i = 0; i < mdAttention.length; i++) _attnRow(mdAttention[i], i == mdAttention.length - 1),
        ]),
      ),
    ]);
  }

  Widget _attnRow(MdAttention it, bool last) {
    final c = mdTone(context, it.tone);
    return _Press(
      onTap: () => _toast(it.label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
        child: Row(children: [
          Container(width: 38, height: 38, alignment: Alignment.center, decoration: BoxDecoration(color: superCoreTint(c, 0x29), borderRadius: BorderRadius.circular(10)), child: Icon(MIcons.of(it.icon), size: 18, color: c)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(it.label, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 13.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
            const SizedBox(height: 1),
            Text(it.desc, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3)),
          ])),
          const SizedBox(width: 8),
          Container(constraints: const BoxConstraints(minWidth: 24), height: 24, alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 7), decoration: BoxDecoration(color: superCoreTint(c, 0x29), borderRadius: BorderRadius.circular(999)), child: Text('${it.count}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12, fontWeight: FontWeight.w700, color: c))),
          const SizedBox(width: 6),
          Icon(MIcons.of('chevR'), size: 16, color: SuperMaterialThemeData.of(context).superTheme.fg4),
        ]),
      ),
    );
  }

  // ── shared bits ──
  Widget _secHead(String title, String marker, {String? sub, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Container(width: 4, height: 22, decoration: BoxDecoration(color: mdMarker(context, marker), borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 16, color: SuperMaterialThemeData.of(context).superTheme.fg1)),
          if (sub != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(sub, style: TextStyle(fontSize: 11.5, color: SuperMaterialThemeData.of(context).superTheme.fg3, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))),
        ])),
        if (trailing != null) trailing,
      ]),
    );
  }

  Widget _viewAllBtn(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('View all', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 12.5, fontWeight: FontWeight.w600, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
        Icon(MIcons.of('chevR'), size: 14, color: SuperMaterialThemeData.of(context).colorScheme.primary),
      ]),
    );
  }

  Widget _pill(String label, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: superCoreTint(c, 0x24), borderRadius: BorderRadius.circular(999)),
      child: Text(label.toUpperCase(), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: c)),
    );
  }

  // ── FAB search ──
  Widget _fab() {
    return PositionedDirectional(
      end: 18, bottom: 92,
      child: _Press(
        onTap: _openSearch,
        child: Container(
          width: 54, height: 54, alignment: Alignment.center,
          decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: superCoreTint(SuperMaterialThemeData.of(context).colorScheme.primary, 0xB3), blurRadius: 22, offset: const Offset(0, 8))]),
          child: const Icon(Icons.search_rounded, size: 24, color: Colors.white),
        ),
      ),
    );
  }

  void _openSearch() {
    showModalBottomSheet<void>(
      context: context, backgroundColor: SuperMaterialThemeData.of(context).superTheme.bg, isScrollControlled: true, useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (_) => _SearchSheet(cur: _cur, factor: _ws.factor),
    );
  }

  // ── bottom nav ──
  Widget _bottomNav() {
    final items = [('home', 'Home', true), ('inbox', 'Accounts', false), ('doc', 'Journal', false), ('dots', 'More', false)];
    return Positioned(
      left: 0, right: 0, bottom: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.bg.withAlpha(0xEB), border: Border(top: BorderSide(color: SuperMaterialThemeData.of(context).superTheme.border))),
            padding: EdgeInsets.only(top: 8, bottom: MediaQuery.of(context).padding.bottom + 10),
            child: Row(children: [
              for (final it in items)
                Expanded(child: _Press(
                  onTap: () => it.$3 ? null : _toast(it.$2),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(MIcons.of(it.$1), size: 21, color: it.$3 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg3),
                    const SizedBox(height: 4),
                    Text(it.$2, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10, fontWeight: it.$3 ? FontWeight.w700 : FontWeight.w500, color: it.$3 ? SuperMaterialThemeData.of(context).colorScheme.primary : SuperMaterialThemeData.of(context).superTheme.fg3)),
                  ]),
                )),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── shimmer bone ──
class _Bone extends StatelessWidget {
  final double w, h;
  const _Bone({required this.w, required this.h});
  @override
  Widget build(BuildContext context) => Container(width: w, height: h, decoration: BoxDecoration(color: SuperMaterialThemeData.of(context).superTheme.inputBg, borderRadius: BorderRadius.circular(6)));
}

/// Tap target with a subtle press-scale (matches the web's :active feedback).
class _Press extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _Press({required this.child, this.onTap});
  @override
  State<_Press> createState() => _PressState();
}

class _PressState extends State<_Press> {
  bool _down = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _down ? 0.96 : 1,
        duration: const Duration(milliseconds: 90),
        child: widget.child,
      ),
    );
  }
}

// ── trend chart painter ──
class _TrendPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final List<String> axis;
  final Color borderColor;
  final Color surfaceColor;
  final Color labelColor;
  final String? fontFamily;
  _TrendPainter({
    required this.values,
    required this.color,
    required this.axis,
    required this.borderColor,
    required this.surfaceColor,
    required this.labelColor,
    required this.fontFamily,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const padL = 8.0, padR = 8.0, padT = 14.0, padB = 22.0;
    final iw = size.width - padL - padR;
    final ih = size.height - padT - padB;
    final n = values.length;
    final minV = values.reduce(math.min);
    final maxV = values.reduce(math.max);
    final span = (maxV - minV) == 0 ? 1 : (maxV - minV);
    final lo = minV - span * 0.18;
    final hi = maxV + span * 0.12;
    double xx(int i) => padL + (n == 1 ? 0.5 : i / (n - 1)) * iw;
    double yy(double v) => padT + ih - ((v - lo) / (hi - lo)) * ih;

    // dashed midline
    final gp = Paint()..color = borderColor..strokeWidth = 1;
    final gy = padT + ih * 0.5;
    double dx = padL;
    while (dx < size.width - padR) { canvas.drawLine(Offset(dx, gy), Offset(dx + 3, gy), gp); dx += 7; }

    final pts = [for (int i = 0; i < n; i++) Offset(xx(i), yy(values[i]))];

    final area = Path()..moveTo(pts.first.dx, padT + ih);
    for (final p in pts) {
      area.lineTo(p.dx, p.dy);
    }
    area.lineTo(pts.last.dx, padT + ih);
    area.close();
    canvas.drawPath(area, Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color.withOpacity(0.30), color.withOpacity(0.02)]).createShader(Rect.fromLTWH(0, padT, size.width, ih)));

    final line = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) {
      line.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(line, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.4..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);

    canvas.drawCircle(pts.last, 4.5, Paint()..color = color);
    canvas.drawCircle(pts.last, 4.5, Paint()..color = surfaceColor..style = PaintingStyle.stroke..strokeWidth = 2.5);

    for (int i = 0; i < axis.length; i++) {
      final idx = ((i / (axis.length - 1)) * (n - 1)).round();
      final tp = TextPainter(text: TextSpan(text: axis[i], style: TextStyle(color: labelColor, fontSize: 10, fontFamily: fontFamily)), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(xx(idx) - tp.width / 2, size.height - 16));
    }
  }

  @override
  bool shouldRepaint(covariant _TrendPainter old) =>
      old.values != values ||
      old.color != color ||
      old.axis != axis ||
      old.borderColor != borderColor ||
      old.surfaceColor != surfaceColor ||
      old.labelColor != labelColor ||
      old.fontFamily != fontFamily;
}

// ── global search sheet ──
class _SearchSheet extends StatefulWidget {
  final String cur;
  final double factor;
  const _SearchSheet({required this.cur, required this.factor});
  @override
  State<_SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<_SearchSheet> {
  String _q = '';
  @override
  Widget build(BuildContext context) {
    final theme = SuperMaterialThemeData.of(context).superTheme;
    final borderColor = theme.border;
    final surfaceColor = theme.surface;
    final labelColor = theme.fg3;
    final all = [for (final t in mdTabs) for (final o in t.ops) (o, t.label)];
    final ql = _q.trim().toLowerCase();
    final results = ql.isEmpty ? all : all.where((e) => '${e.$1.ref} ${e.$1.desc} ${e.$1.type}'.toLowerCase().contains(ql)).toList();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(children: [
            GestureDetector(onTap: () => Navigator.of(context).pop(), child: Container(width: 38, height: 38, alignment: Alignment.center, decoration: BoxDecoration(color: theme.inputBg, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)), child: Icon(MIcons.of('back'), size: 18, color: theme.fg1))),
            const SizedBox(width: 10),
            Expanded(
              child: SuperTextFormField(
                autofocus: true,
                placeholder: 'Search all operations…',
                leadingIcon: Icons.search_rounded,
                clearable: true,
                density: FieldDensity.compact,
                onChanged: (value) => setState(() => _q = value),
              ),
            ),
          ]),
        ),
        Divider(height: 1, color: borderColor),
        Flexible(child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 28), shrinkWrap: true,
          children: [
            Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(_q.trim().isEmpty ? 'SEARCH ACROSS BANKING, ACCOUNTING & COMMERCIAL' : 'RESULTS · ${results.length}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 0.9, color: labelColor))),
            if (results.isEmpty)
              Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Center(child: Text('No matching operations', style: TextStyle(color: theme.fg2, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily))))
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: surfaceColor, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(14)),
                child: Column(children: [
                  for (int i = 0; i < results.length; i++) _row(results[i].$1, results[i].$2, i == results.length - 1),
                ]),
              ),
          ],
        )),
      ]),
    );
  }

  Widget _row(MdOp op, String domain, bool last) {
    final theme = SuperMaterialThemeData.of(context).superTheme;
    final borderColor = theme.border;
    final labelColor = theme.fg3;
    final amtColor = op.isCredit ? SuperMaterialThemeData.of(context).colorScheme.secondary : SuperMaterialThemeData.of(context).colorScheme.error;
    final sign = op.isCredit ? '+' : '−';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: last ? null : Border(bottom: BorderSide(color: borderColor))),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text(op.desc, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: theme.fg1))),
          const SizedBox(width: 10),
          Text('$sign${widget.cur} ${mdNum((op.amt[widget.cur] ?? 0) * widget.factor, decimals: 2)}', style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 14, fontWeight: FontWeight.w700, color: amtColor)),
        ]),
        const SizedBox(height: 7),
        Row(children: [
          Text(op.ref, style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 11, color: SuperMaterialThemeData.of(context).colorScheme.primary)),
          const Spacer(),
          Text(domain.toUpperCase(), style: TextStyle(fontFamily: SuperMaterialThemeData.of(context).textTheme.bodyMedium?.fontFamily, fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: 0.4, color: labelColor)),
        ]),
      ]),
    );
  }
}
