grammar GeneralParser;

file
    : section+ EOF
    ;

section
    : IDENTIFIER (parameterList | recordParameterList)? ('{' section* '}')?
    | IDENTIFIER (parameterList | recordParameterList)? ';'
    ;

parameterList
    : '(' (IDENTIFIER (',' IDENTIFIER)*)? ')'
    ;

recordParameterList
    : '(' (recordParameter (',' recordParameter)*)? ')'
    ;

recordParameter
    : IDENTIFIER IDENTIFIER
    ;

IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

WS
    : [ \t\n\r]+ -> skip
    ;