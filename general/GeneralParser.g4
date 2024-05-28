grammar GeneralParser;

file
    : section+ EOF
    ;

section
    : IDENTIFIER+ sectionContent?
    ;

sectionContent
    : (parameterList | recordParameterList)? whereClause? (blockSection | arrowSection | colonSection)?
    | (parameterList | recordParameterList)? whereClause? ';'
    ;

blockSection
    : '{' section* '}'
    ;

arrowSection
    : '=>' section* ';'
    ;

colonSection
    : ':' section* ';'
    ;

parameterList
    : '(' (parameter (',' parameter)*)? ')'
    ;

parameter
    : IDENTIFIER
    | STRING_LITERAL
    | NUMERIC_LITERAL
    ;

recordParameterList
    : '(' (recordParameter (',' recordParameter)*)? ')'
    ;

recordParameter
    : IDENTIFIER IDENTIFIER
    ;

whereClause
    : 'where' IDENTIFIER ':' IDENTIFIER
    ;

SINGLE_LINE_COMMENT
    : '//' ~[\r\n]* -> skip
    ;

MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip
    ;

STRING_LITERAL
    : '"' (~["\\\r\n] | '\\' (. | EOF))* '"'
    ;

NUMERIC_LITERAL
    : [0-9]+
    ;

IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

WS
    : [ \t\n\r]+ -> skip
    ;