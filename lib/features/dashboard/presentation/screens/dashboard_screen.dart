import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_bloc.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_event.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_state.dart';
import 'package:isoule_ai/features/dashboard/presentation/models/memory_item.dart';
import 'package:isoule_ai/features/memory/presentation/screens/add_memory_screen.dart';
import 'package:isoule_ai/features/reflection/presentation/screens/today_reflection_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildReflectionCard(context),
              const SizedBox(height: 24),
              Text(
                'Recent Memories',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildMemoryList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: kComponentBackground,
          child: Icon(Icons.person, color: kGraySubTitle, size: 28),
        ),
      ],
    );
  }

  Widget _buildReflectionCard(BuildContext context) {
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

  Widget _buildMemoryList() {
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
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: state.memories.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildAddMemoryButton(context);
            }

            final item = state.memories[index - 1];
            return _buildMemoryCard(context, item);
          },
        );
      },
    );
  }

  Widget _buildAddMemoryButton(BuildContext context) {
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

  Widget _buildMemoryCard(BuildContext context, MemoryItem item) {
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
            color: Colors.black.withOpacity(0.05),
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
