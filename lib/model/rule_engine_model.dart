class RuleEngineSettingModel {
  bool maxTimeLimit;
  bool sortByPriority;
  bool preferShorterTasks;
  bool requireTwoCategories;
  bool warnIfHighSkipped;

  RuleEngineSettingModel({
    this.maxTimeLimit = true,
    this.sortByPriority = true,
    this.preferShorterTasks = true,
    this.requireTwoCategories = true,
    this.warnIfHighSkipped = true,
  });

  Map<String, dynamic> toMap() => {
    'maxTimeLimit': maxTimeLimit,
    'sortByPriority': sortByPriority,
    'preferShorterTasks': preferShorterTasks,
    'requireTwoCategories': requireTwoCategories,
    'warnIfHighSkipped': warnIfHighSkipped,
  };

  factory RuleEngineSettingModel.fromMap(Map<String, dynamic> map) => RuleEngineSettingModel(
    maxTimeLimit: map['maxTimeLimit'] ?? true,
    sortByPriority: map['sortByPriority'] ?? true,
    preferShorterTasks: map['preferShorterTasks'] ?? true,
    requireTwoCategories: map['requireTwoCategories'] ?? true,
    warnIfHighSkipped: map['warnIfHighSkipped'] ?? true,
  );
}
