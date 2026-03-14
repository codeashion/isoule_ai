import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_bloc.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_event.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_state.dart';
import 'package:isoule_ai/features/home_screen/presentation/models/memory_item.dart';
import 'package:isoule_ai/features/memory/presentation/screens/add_memory_screen.dart';
import 'package:isoule_ai/features/reflection/presentation/screens/today_reflection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                        'Good Morning',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kGraySubTitle,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nihal',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 26,
                  backgroundColor: kComponentBackground,
                  child: Icon(Icons.person, color: kGraySubTitle, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _AddMemoryButton(),
            const SizedBox(height: 20),
            _ReflectionCard(),
            const SizedBox(height: 24),
            Text(
              'Recent Memories',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(child: _MemoryList()),
            const SizedBox(height: 20),
            const _StorageUsageCard(used: 0.3, totalGb: 2),
          ],
        ),
      ),
    );
  }
}

class _StorageUsageCard extends StatelessWidget {
  const _StorageUsageCard({required this.used, required this.totalGb});

  final double used;
  final int totalGb;

  @override
  Widget build(BuildContext context) {
    final percent = (used / totalGb).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kComponentBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Storage Used',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                '${used.toStringAsFixed(1)} / $totalGb GB',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kGraySubTitle,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              color: kButtonColor,
              backgroundColor: kBackground.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddMemoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          final bloc = context.read<DashboardBloc>();
          final result = await Navigator.push<MemoryItem?>(
            context,
            MaterialPageRoute(builder: (_) => const AddMemoryScreen()),
          );
          if (result != null) {
            bloc.add(AddMemory(result));
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Memory'),
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TodayReflectionScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: kComponentBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.lightbulb_outline, color: kButtonColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Today's Reflection",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: kGraySubTitle),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'What made you smile today?',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Respond →',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: kButtonColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.memories.isEmpty) {
          return Center(
            child: Text(
              'No memories yet. Add one to start your vault!',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.memories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = state.memories[index];
            return _MemoryCard(item: item);
          },
        );
      },
    );
  }
}

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.item});

  final MemoryItem item;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (item.type) {
      case MemoryType.voice:
        icon = Icons.mic;
        break;
      case MemoryType.image:
        icon = Icons.image;
        break;
      default:
        icon = Icons.description;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kComponentBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: kButtonColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
