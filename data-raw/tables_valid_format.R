## code to prepare `tables_valid_format` dataset goes here



tables_valid_format <-  tibble::tribble(
  ~table_type, ~col_type, ~validation_rules,

  ###
  # mapping tables
  ###
  "MappingVocabulariesInfo",
  readr::cols(
    source_vocabulary_id = readr::col_character(),
    twobillionare_code = readr::col_character(),
    path_to_usagi_file = readr::col_character(),
    path_to_usagi_file = readr::col_character(),
    mapping_version = readr::col_character(),
    last_modify_date = readr::col_date(format = ""),
    mapping_type = readr::col_character(),
    ignore = readr::col_logical()
  ),
  validate::validator(
    all.fileds.have.a.value = all_complete(names(validation_rules)),
    source_vocabulary_id.is.unique = is_unique(source_vocabulary_id),
    twobillionare_code.is.unique = is_unique(twobillionare_code),
    mapping_type.valid.values.are.CCR.or.STCM = mapping_type %in% c("CCR", "STCM")
  ),
  #
  "UsagiForCCR",
  readr::cols(
    sourceCode = readr::col_character(),
    sourceName = readr::col_character(),
    sourceFrequency = readr::col_integer(),
    sourceAutoAssignedConceptIds = readr::col_integer(),
    `ADD_INFO:sourceConceptId` = readr::col_integer(),
    `ADD_INFO:sourceName_fi` = readr::col_character(),
    `ADD_INFO:sourceConceptClass` = readr::col_character(),
    `ADD_INFO:sourceDomain` = readr::col_character(),
    `ADD_INFO:sourceValidStartDate` = readr::col_date(),
    `ADD_INFO:sourceValidEndDate` = readr::col_date(),
    matchScore = readr::col_double(),
    mappingStatus = readr::col_character(),
    equivalence = readr::col_character(),
    statusSetBy = readr::col_character(),
    statusSetOn = readr::col_double(),
    conceptId = readr::col_integer(),
    conceptName = readr::col_character(),
    domainId = readr::col_character(),
    mappingType = readr::col_character(),
    comment = readr::col_character(),
    createdBy = readr::col_character(),
    createdOn = readr::col_double(),
    assignedReviewer = readr::col_character(),
    .default = readr::col_character()
  ),
  validate::validator(
    sourceCode.and.conceptId.are.uniques = is_unique(sourceCode, conceptId),
    sourceCode.is.not.empty = is_complete(sourceCode),
    sourceName.is.not.empty = is_complete(sourceName)
  ),
  #
  "VocabularyInfo",
  readr::cols(
    concept_id = readr::col_integer(),
    type = readr::col_character(),
    text_id = readr::col_character(),
    text_name = readr::col_character()
  ),
  validate::validator(
    concept_id.is.uniques = is_unique(concept_id)
  ),
  #
  "VocabulariesCoverage",
  readr::cols(
    source_vocabulary_id = readr::col_character(),
    target_vocabulary_ids = readr::col_character(),
    mantained_by = readr::col_character(),
    ignore = readr::col_logical()
  ),
  validate::validator(
    source_vocabulary_id.is.not.na = is_complete(source_vocabulary_id),
    target_vocabulary_ids.is.not.na = is_complete(target_vocabulary_ids),
    source_vocabulary_id.and.target_vocabulary_ids.is.uniques = is_unique(concept_id)
  ),
  #
  "DatabasesCodeCounts",
  readr::cols(
    database_name = readr::col_character(),
    path_to_code_counts_file = readr::col_character(),
    ignore = readr::col_logical()
  ),
  validate::validator(
    database_name.is.not.na = is_complete(database_name),
    path_to_code_counts_file.is.not.na = is_complete(path_to_code_counts_file)
  ),
  "CodeCounts",
  readr::cols(
    source_vocabulary_id = readr::col_character(),
    source_code = readr::col_character(),
    n_events = readr::col_integer()
  ),
  validate::validator(
    source_vocabulary_id.is.not.na = is_complete(source_vocabulary_id),
    source_vocabulary_id.and.source_code.are.unique = is_unique(source_vocabulary_id, source_code),
    n_events.is.more.than.5.or.minus.one = n_events>5|n_events==-1
  ),
  ###
  # OMOP vocabulary tables
  ###
  "CONCEPT",
  readr::cols(
    concept_id = readr::col_integer(),
    concept_name = readr::col_character(),
    domain_id = readr::col_character(),
    vocabulary_id = readr::col_character(),
    concept_class_id = readr::col_character(),
    standard_concept = readr::col_character(),
    concept_code = readr::col_character(),
    valid_start_date = readr::col_date("%Y%m%d"),
    valid_end_date = readr::col_date("%Y%m%d"),
    invalid_reason = readr::col_character()
  ),
  validate::validator(
    concept_id.is.unique = is_unique(concept_id),
    concept_name.lessthan.255char = field_length(concept_name, min=0, max=255),
    domain_id.lessthan.20char = field_length(domain_id , min=0, max=20),
    vocabulary_id.lessthan.20char = field_length(vocabulary_id, min=0, max=20),
    concept_class_id.lessthan.20char = field_length(concept_class_id, min=0, max=20),
    standard_concept.equal.1char = field_length(standard_concept, n=1),
    concept_code.lessthan.50char = field_length(concept_code, min=0, max=50)
  ),
  #
  "CONCEPT_ANCESTOR",
  readr::cols(
    ancestor_concept_id  = readr::col_integer(),
    descendant_concept_id  = readr::col_integer(),
    min_levels_of_separation  = readr::col_integer(),
    max_levels_of_separation = readr::col_integer()
  ),
  validate::validator(),
  #
  "CONCEPT_CLASS",
  readr::cols(
    concept_class_id = readr::col_character(),
    concept_class_name = readr::col_character(),
    concept_class_concept_id = readr::col_integer()
  ),
  validate::validator(),
  #
  "CONCEPT_RELATIONSHIP",
  readr::cols(
    concept_id_1 = readr::col_integer(),
    concept_id_2 = readr::col_integer(),
    relationship_id = readr::col_character(),
    valid_start_date =  readr::col_date("%Y%m%d"),
    valid_end_date =  readr::col_date("%Y%m%d"),
    invalid_reason = readr::col_character()
  ),
  validate::validator(),
  #
  "CONCEPT_SYNONYM",
  readr::cols(
    concept_id = readr::col_integer(),
    concept_synonym_name = readr::col_character(),
    language_concept_id = readr::col_integer()
  ),
  validate::validator(),
  #
  "DOMAIN",
  readr::cols(
    domain_id = readr::col_character(),
    domain_name = readr::col_character(),
    domain_concept_id = readr::col_integer()
  ),
  validate::validator(),
  #
  "DRUG_STRENGTH",
  readr::cols(
    drug_concept_id = readr::col_integer(),
    ingredient_concept_id = readr::col_integer(),
    amount_value = readr::col_double(),
    amount_unit_concept_id = readr::col_integer(),
    numerator_value = readr::col_double(),
    numerator_unit_concept_id = readr::col_integer(),
    denominator_value = readr::col_double(),
    denominator_unit_concept_id = readr::col_integer(),
    box_size = readr::col_integer(),
    valid_start_date =  readr::col_date("%Y%m%d"),
    valid_end_date =  readr::col_date("%Y%m%d"),
    invalid_reason = readr::col_character()
  ),
  validate::validator(),
  #
  "RELATIONSHIP",
  readr::cols(
    relationship_id = readr::col_character(),
    relationship_name = readr::col_character(),
    is_hierarchical = readr::col_character(),
    defines_ancestry = readr::col_character(),
    reverse_relationship_id = readr::col_character(),
    relationship_concept_id = readr::col_integer()
  ),
  validate::validator(),
  #
  "VOCABULARY",
  readr::cols(
    vocabulary_id = readr::col_character(),
    vocabulary_name = readr::col_character(),
    vocabulary_reference = readr::col_character(),
    vocabulary_version = readr::col_character(),
    vocabulary_concept_id = readr::col_integer()
  ),
  validate::validator()
)

usethis::use_data(tables_valid_format, overwrite = TRUE)