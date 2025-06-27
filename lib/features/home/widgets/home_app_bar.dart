import 'package:business_transactions/config/constants/string_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? username;
  final String balanceValue;
  final TabController tabController;

  const HomeAppBar(
      {super.key,
      this.username,
      required this.balanceValue,
      required this.tabController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        '$homeTitlePrefix ${username ?? ''},'.trim(),
        style: textTheme.headlineSmall!.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: colorScheme.shadow.withValues(alpha: 0.25),
            )
          ],
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SvgPicture.asset(
          appbarWavesSvgPath,
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(
            _BalanceCard.kEstimatedTotalHeightWithMargin + kTextTabBarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BalanceCard(
              balanceValue: balanceValue,
              balanceTitle: balanceAmount,
            ),
            _TabBar(tabController: tabController),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    const double balanceCardHeight =
        _BalanceCard.kEstimatedTotalHeightWithMargin;
    const double tabBarHeight = kTextTabBarHeight;

    return Size.fromHeight(kToolbarHeight + balanceCardHeight + tabBarHeight);
  }
}

class _BalanceCard extends StatelessWidget {
  final String balanceValue;
  final String balanceTitle;

  const _BalanceCard({required this.balanceValue, required this.balanceTitle});

  static const double _kCardContentHeight = 100.0;
  static const double _kSingleSideVerticalMargin = 8.0;
  static const double kEstimatedTotalHeightWithMargin =
      _kCardContentHeight + _kSingleSideVerticalMargin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: _kCardContentHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.surface.withValues(alpha: 0.85),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(
          bottom: _kSingleSideVerticalMargin,
          left: 16,
          right: 16), // Margin applied here
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            balanceTitle,
            style: textTheme.titleMedium!.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            balanceValue,
            style: textTheme.headlineLarge!.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const _TabBar({required this.tabController});

  static const List<Tab> _tabs = [
    Tab(text: customers),
    Tab(text: vendors),
    Tab(text: history),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TabBar(
      controller: tabController,
      isScrollable: true,
      indicatorColor: colorScheme.onPrimary,
      labelColor: colorScheme.onPrimary,
      unselectedLabelColor: colorScheme.onPrimary.withValues(alpha: 0.7),
      labelStyle: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: textTheme.titleSmall,
      indicatorWeight: 3.0,
      indicatorSize: TabBarIndicatorSize.label,
      splashBorderRadius: BorderRadius.circular(8),
      tabs: _tabs,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
