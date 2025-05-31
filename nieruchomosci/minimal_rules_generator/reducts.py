import pandas as pd
import numpy as np
from typing import List, Set, Tuple, Dict
from itertools import combinations


class ReductsFinder:
    def __init__(self, data: pd.DataFrame, decision_attribute: str):
        self.data = data.copy()
        self.decision_attribute = decision_attribute
        self.conditional_attributes = [col for col in data.columns if col != decision_attribute]
    
    def get_indiscernibility_relation(self, attributes: List[str]) -> Dict[int, Set[int]]:
        equivalence_classes = {}
        
        for idx in self.data.index:
            if idx not in equivalence_classes:
                # Find all objects indiscernible from current object
                equivalent_objects = set([idx])
                current_values = self.data.loc[idx, attributes].values
                
                for other_idx in self.data.index:
                    if other_idx != idx and other_idx not in equivalence_classes:
                        other_values = self.data.loc[other_idx, attributes].values
                        if np.array_equal(current_values, other_values):
                            equivalent_objects.add(other_idx)
                
                # Assign same equivalence class to all equivalent objects
                for obj in equivalent_objects:
                    equivalence_classes[obj] = equivalent_objects
                    
        return equivalence_classes
    
    def is_consistent(self, attributes: List[str]) -> bool:
        """
        Check if the given set of attributes is consistent (no contradictions).
        """
        indiscernibility = self.get_indiscernibility_relation(attributes)
        
        processed_classes = set()
        for obj_idx in self.data.index:
            equiv_class = indiscernibility[obj_idx]
            
            # Avoid processing the same equivalence class multiple times
            equiv_class_tuple = tuple(sorted(equiv_class))
            if equiv_class_tuple in processed_classes:
                continue
                
            processed_classes.add(equiv_class_tuple)
            
            # Check if all objects in equivalence class have same decision value
            decision_values = set()
            for obj in equiv_class:
                decision_values.add(self.data.loc[obj, self.decision_attribute])
                
            if len(decision_values) > 1:
                return False
                
        return True
    
    
    def is_reduct(self, attributes: List[str]) -> bool:
        if not self.is_consistent(attributes):
            return False
            
        # Check if removing any attribute makes it inconsistent
        for attr in attributes:
            reduced_attrs = [a for a in attributes if a != attr]
            if reduced_attrs and self.is_consistent(reduced_attrs):
                return False
                
        return True
    
    def find_all_reducts(self) -> List[List[str]]:
        reducts = []
        n_attrs = len(self.conditional_attributes)
        
        # Start with smallest possible subsets and work up
        for size in range(1, n_attrs + 1):
            found_reduct_of_this_size = False
            
            for attr_combination in combinations(self.conditional_attributes, size):
                attr_list = list(attr_combination)
                
                if self.is_reduct(attr_list):
                    reducts.append(attr_list)
                    found_reduct_of_this_size = True
            
            # If we found reducts of this size, no need to check larger sizes
            # (since we want minimal reducts)
            if found_reduct_of_this_size and reducts:
                break
                
        return reducts
    
    def find_reducts_with_core(self) -> Tuple[List[str], List[List[str]]]:
        # Find core attributes (attributes that appear in all reducts)
        all_reducts = self.find_all_reducts()
        
        if not all_reducts:
            return [], []
        
        # Core is intersection of all reducts
        core = set(all_reducts[0])
        for reduct in all_reducts[1:]:
            core = core.intersection(set(reduct))
            
        return list(core), all_reducts
    

def find_reducts(data: pd.DataFrame, decision_attribute: str) -> Dict[str, any]:
    analyzer = ReductsFinder(data, decision_attribute)
    
    core, all_reducts = analyzer.find_reducts_with_core()
    
    reduct_dependencies = {}
    for i, reduct in enumerate(all_reducts):
        reduct_dependencies[f"reduct_{i+1}"] = {
            "attributes": reduct,
        }
    
    results = {
        "core_attributes": core,
        "all_reducts": all_reducts,
        "reduct_details": reduct_dependencies,
        "is_consistent": analyzer.is_consistent(analyzer.conditional_attributes),
        "number_of_reducts": len(all_reducts)
    }
    
    return results
