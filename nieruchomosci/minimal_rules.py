import pandas as pd
import numpy as np
from itertools import combinations
from sklearn.metrics import accuracy_score
from tqdm import tqdm


def generate_rules(df, features):
    rules = []
    for feature in features:
        unique_values = df[feature].unique()
        is_numeric = pd.api.types.is_numeric_dtype(df[feature])
        for value in unique_values:
            if is_numeric:
                rule_lt = (feature, '<=', value)
                rules.append(rule_lt)
                
                rule_gt = (feature, '>=', value)
                rules.append(rule_gt)
            else:
                rule_eq = (feature, '=', value)
                rules.append(rule_eq)
    return rules


def evaluate_rule(df, rule):
    feature, operator, value = rule
    if operator == '<=':
        mask = df[feature] <= value
    elif operator == '>=':
        mask = df[feature] >= value
    else:
        mask = df[feature] == value
    return mask


def find_minimal_rules(df, features, target_column, target_value, min_accuracy):
    all_rules = generate_rules(df, features)
    minimal_rules = []
    
    # single rules
    for rule in all_rules:
        prediction = evaluate_rule(df, rule)
        accuracy = accuracy_score(df[target_column] == target_value, prediction)
        if accuracy >= min_accuracy:
            minimal_rules.append(([rule], accuracy))
    
    # combinations of rules
    for i in range(2, len(features) + 1):
        for rules_combo in tqdm(list(combinations(all_rules, i)), desc=f"Combining {i} rules"):
            if len(set([r[0] for r in rules_combo])) != i:
                continue
            
            combined_prediction = np.ones(len(df), dtype=bool)
            for rule in rules_combo:
                rule_prediction = evaluate_rule(df, rule)
                combined_prediction = combined_prediction & rule_prediction
            
            accuracy = accuracy_score(df[target_column] == target_value, combined_prediction)
            
            if accuracy >= min_accuracy:
                # check if the combination is minimal
                is_minimal = True
                for j in range(len(rules_combo)):
                    subset = list(rules_combo)
                    del subset[j]
                    
                    subset_prediction = np.ones(len(df), dtype=bool)
                    for sub_rule in subset:
                        sub_rule_prediction = evaluate_rule(df, sub_rule)
                        subset_prediction = subset_prediction & sub_rule_prediction
                    
                    subset_accuracy = accuracy_score(df[target_column] == target_value, subset_prediction)
                    
                    if subset_accuracy >= accuracy:
                        is_minimal = False
                        break
                
                if is_minimal:
                    minimal_rules.append((list(rules_combo), accuracy))
    return minimal_rules


def generate_prolog_rule(rule, entity, target_column, target_value):
    rule_str = f"{target_column.lower()}({entity}, {target_value}) :-\n"

    rule_features = set([r[0] for r in rule[0]])
    for feature in rule_features:
        rule_str += f"    {entity.lower()}_{feature.lower()}({entity}, {feature}),\n"
    
    for condition in rule[0]:
        feature, operator, value = condition
        if operator == '<=':
            rule_str += f"    {feature} =< {value},\n"
        elif operator == '>=':
            rule_str += f"    {feature} >= {value},\n"
        else:
            rule_str += f"    {feature} = {value},\n"
    rule_str = rule_str.rstrip(',\n') + '.\n'
    return rule_str