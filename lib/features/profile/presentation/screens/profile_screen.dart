import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/delete_account/presentation/screens/delete_account_screen.dart';
import 'package:isoule_ai/features/manage_data/presentation/screens/manage_data_screen.dart';
import 'package:isoule_ai/features/profile/presentation/widgets/refer_rewards_wallet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _ProfileBloc(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileHeader(),
              const SizedBox(height: 20),
              const _StorageCard(),
              const SizedBox(height: 16),
              const SectionHeader(title: 'AI Personalization'),
              const _OptionTile(
                title: 'Daily Reflection',
                subtitle: 'Scheduled for 9:00 PM',
                icon: Icons.auto_stories_outlined,
              ),
              const _OptionTile(
                title: 'Memory Analysis',
                subtitle: 'Deep (Recommended)',
                icon: Icons.analytics_outlined,
              ),
              const SizedBox(height: 16),
              const SectionHeader(title: 'Account Security'),
              const _OptionTile(
                title: 'Change Password',
                subtitle: 'Update your login',
                icon: Icons.lock_outline,
              ),
              BlocBuilder<_ProfileBloc, _ProfileState>(
                builder: (context, state) {
                  return _OptionTile(
                    title: 'Biometric Lock',
                    subtitle: 'Use face or fingerprint',
                    icon: Icons.fingerprint,
                    trailing: Switch(
                      value: state.notificationsEnabled,
                      onChanged: (value) {
                        context.read<_ProfileBloc>().add(
                          _ProfileToggleNotifications(value),
                        );
                      },
                      activeColor: kButtonColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const SectionHeader(title: 'App Settings'),
              const _OptionTile(
                title: 'Notifications',
                subtitle: 'Push & email settings',
                icon: Icons.notifications_outlined,
              ),
              const _OptionTile(
                title: 'Help & Support',
                subtitle: 'Get help with the app',
                icon: Icons.help_outline,
              ),
              const SizedBox(height: 16),
              const ReferralRewardsSection(),
              const SizedBox(height: 24),
              _ActionButton(
                label: 'Delete Account',
                icon: Icons.delete_outline,
                background: const Color(0xFFFFE5E5),
                foreground: const Color(0xFFD82323),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccountScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: kComponentBackground,
                child: Icon(Icons.person, color: kGraySubTitle, size: 44),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kBackground, width: 2),
                ),
                child: const Icon(Icons.edit, size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Arjun Mehta',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'arjun.mehta@example.com',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: kComponentBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Free Plan',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: kButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _StorageCard extends StatelessWidget {
  const _StorageCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kComponentBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cloud Storage',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '1.3 GB of 2.0 GB used',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Free Plan',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: 1.3 / 2.0,
              minHeight: 10,
              color: kButtonColor,
              backgroundColor: kBackground.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageStorageScreen(),
                      ),
                    );
                  },
                  child: const Text('Manage Data'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upgrade Plan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kComponentBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: kButtonColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
          if (trailing == null) ...[
            const Icon(Icons.chevron_right, color: kGraySubTitle),
          ],
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foreground),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileState {
  final double usedStorage;
  final bool notificationsEnabled;

  const _ProfileState({
    required this.usedStorage,
    required this.notificationsEnabled,
  });

  _ProfileState copyWith({double? usedStorage, bool? notificationsEnabled}) {
    return _ProfileState(
      usedStorage: usedStorage ?? this.usedStorage,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

abstract class _ProfileEvent {}

class _ProfileToggleNotifications extends _ProfileEvent {
  final bool enabled;

  _ProfileToggleNotifications(this.enabled);
}

class _ProfileBloc extends Bloc<_ProfileEvent, _ProfileState> {
  _ProfileBloc()
    : super(
        const _ProfileState(usedStorage: 0.15, notificationsEnabled: true),
      ) {
    on<_ProfileToggleNotifications>((event, emit) {
      emit(state.copyWith(notificationsEnabled: event.enabled));
    });
  }
}
