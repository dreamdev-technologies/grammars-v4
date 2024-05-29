grammar GeneralParser;

file
    : section+ EOF
    ;

section
    : IDENTIFIER+ sectionContent?
    ;

sectionContent
    : (parameterList | recordParameterList | importSection)? whereClause? (blockSection | arrowSection | colonSection)?
    | (parameterList | recordParameterList | importSection)? whereClause? ';'
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

importSection
    : importList ('from' STRING_LITERAL)?
    ;

importList
    : '{' (importParameter (',' importParameter)*)? '}'
    ;

importParameter
    : IDENTIFIER
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
    | '\'' (~['\\\r\n] | '\\' (. | EOF))* '\''
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