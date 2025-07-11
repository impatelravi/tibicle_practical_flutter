import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/rule_engine_bloc/rule_engine_cubit.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/rule_engine_bloc/rule_engine_state.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_event.dart';

class RuleEngineSettingsScreen extends StatelessWidget {
  const RuleEngineSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RuleEngineCubit()..loadSettings(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Rule Engine Settings')),
        body: BlocBuilder<RuleEngineCubit, RuleEngineState>(
          builder: (context, state) {
            final ruleEngineCubit = context.read<RuleEngineCubit>();
            final s = state.settings;

            return ListView(
              children: [
                SwitchListTile(
                  title: const Text('Limit total time to 240 mins'),
                  value: s.maxTimeLimit,
                  onChanged: (value) {
                    ruleEngineCubit.updateSetting((newSettings) {
                      newSettings.maxTimeLimit = value;
                      context.read<TaskBloc>().add(
                        UpdateRuleEngineSettingsEvent(newSettings),
                      );
                      return newSettings;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Sort by priority'),
                  value: s.sortByPriority,
                  onChanged: (value) {
                    ruleEngineCubit.updateSetting((newSettings) {
                      newSettings.sortByPriority = value;
                      context.read<TaskBloc>().add(
                        UpdateRuleEngineSettingsEvent(newSettings),
                      );
                      return newSettings;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Prefer shorter tasks'),
                  value: s.preferShorterTasks,
                  onChanged: (value) {
                    ruleEngineCubit.updateSetting((newSettings) {
                      newSettings.preferShorterTasks = value;
                      context.read<TaskBloc>().add(
                        UpdateRuleEngineSettingsEvent(newSettings),
                      );
                      return newSettings;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Include at least two categories'),
                  value: s.requireTwoCategories,
                  onChanged: (value) {
                    ruleEngineCubit.updateSetting((newSettings) {
                      newSettings.requireTwoCategories = value;
                      context.read<TaskBloc>().add(
                        UpdateRuleEngineSettingsEvent(newSettings),
                      );
                      return newSettings;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Warn if high-priority task is skipped'),
                  value: s.warnIfHighSkipped,
                  onChanged: (value) {
                    ruleEngineCubit.updateSetting((newSettings) {
                      newSettings.warnIfHighSkipped = value;
                      context.read<TaskBloc>().add(
                        UpdateRuleEngineSettingsEvent(newSettings),
                      );
                      return newSettings;
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
