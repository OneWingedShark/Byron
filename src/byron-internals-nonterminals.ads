Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Internals.Actions,
Byron.Types.Enumerations,
Byron.Tokens.Nonterminal_Instance;

use
Byron.Internals.Actions,
Byron.Types.Enumerations,
Byron.Tokens.Nonterminal_Instance;

-- Byron.Internals.Nonterminals contains all the definitions for the nonterminal
-- symbols used in the grammar.
Package Byron.Internals.Nonterminals is

--     -- Nonterminals stolen from:
--     -- http://cui.unige.ch/db-research/Enseignement/analyseinfo/Ada95/BNFindex.html
--
--     nt_Prime                         : aliased Class := Get (p_Prime);
--     nt_CU                            : aliased Class := Get (p_Compilation_Unit);
--     nt_Context_Clause                : aliased Class := Get (P_Prime); --p_Context_Clause);
--
--     ----------
--     -- TO DO:   (1) Add enumerations, (2) alter Get call,
--     --          (3) Add names [2nd param], (4) Add actions [3rd param].
--     nt_Llibrary_Item                 : aliased Class := Get (P_Prime);
--     nt_Subunit                       : aliased Class := Get (P_Prime);
--     nt_Library_Unit_Declaration      : aliased Class := Get (P_Prime);
--     nt_Library_Unit_Body             : aliased Class := Get (P_Prime);
--     nt_Library_Unit_Renaming         : aliased Class := Get (P_Prime);
--     nt_Subprogram_Declaration        : aliased Class := Get (P_Prime);
--     nt_package_declaration           : aliased Class := Get (P_Prime);
--     nt_generic_declaration           : aliased Class := Get (P_Prime);
--     nt_generic_instantiation         : aliased Class := Get (P_Prime);
--     nt_subprogram_body               : aliased Class := Get (P_Prime);
--     nt_package_body                  : aliased Class := Get (P_Prime);
--     nt_package_renaming,
--     nt_generic_renaming,
--     nt_subprogram_renaming,
--     nt_subprogram_specification,
--     nt_package_specification,
--     nt_generic_formal_parameters,
--     nt_use_clause,
--     nt_defining_program_unit_name,
--     nt_package_name,
--     nt_generic_actual_part,
--     nt_procedure_name,
--     nt_defining_designator,
--     nt_function_name,
--     nt_declarative_part,
--     nt_handled_sequence_of_statements,
--     nt_designator,
--     nt_parent_unit_name,
--     nt_name,
--     nt_formal_part,
--     nt_subtype_mark,
--     nt_basic_declarative_item,
--     nt_identifier, ------------- I don't think We don't need this as it is a terminal.
--
--     nt_formal_object_declaration,
--     nt_formal_type_declaration,
--     nt_formal_subprogram_declaration,
--     nt_formal_package_declaration,
--     nt_defining_identifier,
--     nt_generic_association,
--     nt_defining_operator_symbol,
--     nt_body,
--     nt_sequence_of_statements,
--     nt_exception_handler,
--     nt_operator_symbol,
--     nt_direct_name,
--     nt_explicit_dereference,
--     nt_indexed_component,
--     nt_slice,
--     nt_selected_component,
--     nt_attribute_reference,
--     nt_type_conversion,
--     nt_function_call,
--     nt_character_literal,
--     nt_parameter_specification,
--     nt_representation_clause,
--     nt_defining_identifier_list,
--     nt_mode,
--     nt_default_expression,
--     nt_discriminant_part,
--     nt_formal_type_definition,
--     nt_default_name,
--     nt_formal_package_actual_part,
--     nt_selector_name,
--     nt_expression,
--     nt_variable_name,
--     nt_entry_name,
--     nt_proper_body,
--     nt_body_stub,
--     nt_statement,
--     nt_choice_parameter_specification,
--     nt_exception_choice,
--     nt_string_literal,
--     nt_prefix,
--     nt_discrete_range,
--     nt_attribute_designator,
--     nt_actual_parameter_part,
--     nt_access_definition,
--     nt_attribute_definition_clause,
--     nt_enumeration_representation_clause,
--     nt_record_representation_clause,
--     nt_at_clause,
--     nt_known_discriminant_part,
--     nt_formal_private_type_definition,
--     nt_formal_derived_type_definition,
--     nt_formal_discrete_type_definition,
--     nt_formal_signed_integer_type_definition,
--     nt_formal_modular_type_definition,
--     nt_formal_floating_point_definition,
--     nt_formal_ordinary_fixed_point_definition,
--     nt_formal_decimal_fixed_point_definition,
--     nt_formal_array_type_definition,
--     nt_formal_access_type_definition,
--     nt_task_body,
--     nt_protected_body,
--     nt_subprogram_body_stub,
--     nt_package_body_stub,
--     nt_task_body_stub,
--     nt_protected_body_stub,
--     nt_label,
--     nt_simple_statement,
--     nt_compound_statement,
--     nt_string_element,
--     nt_relation,
--     nt_subtype_indication,
--     nt_range,
--     nt_parameter_association,
--     nt_local_name,
--     nt_first_subtype_local_name,
--     nt_mod_clause,
--     nt_component_clause,
--     nt_discriminant_specification,
--     nt_access_type_definition,
--     nt_array_type_definition ,
--     nt_task_identifier,
--     nt_protected_operation_item,
--     nt_protected_identifier,
--     nt_statement_identifier,
--     nt_null_statement,
--     nt_assignment_statement,
--     mt_exit_statement,
--     nt_goto_statement,
--     nt_procedure_call_statement,
--     nt_return_statement,
--     nt_entry_call_statement,
--     nt_requeue_statement,
--     nt_delay_statement,
--     nt_abort_statement,
--     nt_raise_statement,
--     nt_code_statement,
--
--     nt_if_statement ,
--     nt_case_statement,
--     mt_loop_statement,
--     nt_block_statement,
--     nt_accept_statement,
--     nt_select_statement,
--     nt_simple_expression,
--     nt_range_attribute_reference,
--     nt_constraint,
--     nt_library_unit_name,
--     nt_static_expression,
--     nt_first_bit,
--     nt_last_bit,
--     nt_access_to_object_definition,
--     nt_access_to_subprogram_definition,
--     nt_unconstrained_array_definition,
--     nt_constrained_array_definition,
--     nt_entry_body,
--     nt_qualified_expression,
--     nt_exception_name,
--     nt_task_name,
--     nt_delay_until_statement,
--     nt_delay_relative_statement,
--     nt_label_name,
--     nt_loop_name,
--     nt_condition,
--     nt_case_statement_alternative,
--     nt_discrete_subtype_definition,
--     nt_entry_index,
--     nt_parameter_profile,
--     nt_entry_identifier,
--     nt_selective_accept,
--     nt_timed_entry_call,
--     nt_conditional_entry_call,
--     nt_asynchronous_select,
--     nt_term,
--     nt_range_attribute_designator,
--     nt_range_constraint,
--     nt_digits_constraint,
--     nt_delta_constraint,
--     nt_index_constraint,
--     nt_discriminant_constraint,
--     nt_static_simple_expression ,
--     nt_parameter_and_result_profile,
--     nt_index_subtype_definition,
--     nt_component_definition,
--     nt_entry_body_formal_part,
--     nt_entry_barrier,
--     nt_aggregate,
--     nt_discrete_choice_list,
--     nt_triggering_alternative,
--     nt_abortable_part,
--     nt_entry_call_alternative,
--     nt_delay_alternative,
--     nt_guard,
--     nt_select_alternative,
--     nt_factor,
--     nt_discriminant_association,
--     nt_entry_index_specification,
--     nt_record_aggregate,
--     nt_extension_aggregate,
--     nt_array_aggregate,
--     nt_discrete_choice,
--     nt_triggering_statement,
--     nt_primary,
--     nt_record_component_association,
--     nt_ancestor_part,
--     nt_positional_array_aggregate,
--     nt_named_array_aggregate,
--     nt_numeric_literal,
--     nt_allocator,
--     nt_component_choice_list,
--     nt_array_component_association,
--     nt_decimal_literal,
--     nt_based_literal,
--     nt_numeral,
--     nt_exponent,
--     nt_base,
--     nt_based_numeral,
--     nt_extended_digit,
--
--     nt_pragma,
--     nt_pragma_argument_association,
--     nt_type_declaration,
--     nt_incomplete_type_declaration,
--     nt_private_type_declaration,
--     nt_private_extension_declaration,
--     nt_full_type_declaration,
--     nt_task_type_declaration,
--     nt_protected_type_declaration,
--     nt_type_definition,
--     nt_enumeration_type_definition,
--     nt_integer_type_definition,
--     nt_real_type_definition,
--     nt_record_type_definition,
--     nt_derived_type_definition,
--     nt_subtype_declaration,
--     nt_object_declaration,
--     nt_single_task_declaration,
--     nt_single_protected_declaration,
--     nt_ancestor_subtype_indication,
--     nt_enumeration_literal_specification,
--     nt_floating_point_definition,
--     nt_ordinary_fixed_point_definition,
--     nt_decimal_fixed_point_definition,
--     nt_record_definition,
--     nt_record_extension_part,
--     nt_task_definition,
--     nt_protected_definition,
--     nt_component_item,
--     nt_variant_part,
--     nt_task_item,
--     nt_protected_operation_declaration,
--     nt_protected_element_declaration,
--     nt_component_declaration,
--     nt_variant,
--     nt_entry_declaration,
--     nt_abstract_subprogram_declaration,
--     nt_renaming_declaration,
--     nt_accept_alternative,
--     nt_terminate_alternative,
--     nt_with_clause,
--     nt_exception_declaration,
--     nt_generic_subprogram_declaration,
--     nt_generic_package_declaration,
--     nt_generic_formal_part,
--     nt_restriction_pragma
--
--
--
--
--
--     : aliased Class := Get (P_Prime);

   Function Create_Instance( X : nt_Range ) return nt_Access is
     ( new Class'( Get (X, Image(X), nt_Procedures(X)) ) )
   with Inline, Pure_Function;

   Function Create_Instances( X : nt_Range ) return nt_Action is
     (if X = nt_Range'First
      then (X => Create_Instance(X))
      else Create_Instances(nt_Range'Pred(X)) & (X => Create_Instance(X))
     ) with Inline, Pure_Function;
   Function Create_Instances return nt_Action is
     (Create_Instances(nt_Range'Last))
   with Inline, Pure_Function;

   N : nt_Action(nt_Procedures'Range) := Create_Instances;

   nt_Prime	: nt_Access renames N(P_Prime);
   nt_CU	: nt_Access renames N(p_Compilation_Unit);

--   nt_Prime : aliased Class renames g.All;
End Byron.Internals.Nonterminals;