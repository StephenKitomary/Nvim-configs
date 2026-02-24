" Vim syntax file for Nuru Programming Language
" Language: Nuru (Swahili Programming Language)

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Keywords
syn keyword nuruDeclaration fanya
syn keyword nuruFunction unda
syn keyword nuruConditional kama sivyo au
syn keyword nuruRepeat wakati kwa ktk
syn keyword nuruStatement rudisha vunja endelea
syn keyword nuruInclude tumia pakeji
syn keyword nuruBoolean kweli sikweli
syn keyword nuruNull tupu

" Built-in functions
syn keyword nuruBuiltin andika jaza sukuma urefu aina badilisha
syn keyword nuruBuiltin jumla fungua soma funga futa

" Operators
syn match nuruOperator "\v\+"
syn match nuruOperator "\v-"
syn match nuruOperator "\v\*"
syn match nuruOperator "\v/"
syn match nuruOperator "\v\%"
syn match nuruOperator "\v\=\="
syn match nuruOperator "\v!\="
syn match nuruOperator "\v\<\="
syn match nuruOperator "\v\>\="
syn match nuruOperator "\v\<"
syn match nuruOperator "\v\>"
syn match nuruOperator "\v\&\&"
syn match nuruOperator "\v\|\|"
syn match nuruOperator "\v!"
syn match nuruOperator "\v\+\+"
syn match nuruOperator "\v--"

" Numbers
syn match nuruNumber "\v<\d+>"
syn match nuruFloat "\v<\d+\.\d+>"

" Strings
syn region nuruString start=/"/ skip=/\\"/ end=/"/ contains=nuruEscape
syn region nuruString start=/'/ skip=/\\'/ end=/'/ contains=nuruEscape
syn match nuruEscape "\\[nrt\\\"'0]" contained

" Comments
syn match nuruComment "//.*$" contains=nuruTodo
syn region nuruComment start="/\*" end="\*/" contains=nuruTodo
syn keyword nuruTodo TODO FIXME XXX NOTE contained

" Delimiters
syn match nuruDelimiter "[(){}[\]:;,.]"

" Highlight links
hi def link nuruDeclaration StorageClass
hi def link nuruFunction Keyword
hi def link nuruConditional Conditional
hi def link nuruRepeat Repeat
hi def link nuruStatement Statement
hi def link nuruInclude Include
hi def link nuruBoolean Boolean
hi def link nuruNull Constant
hi def link nuruBuiltin Function
hi def link nuruOperator Operator
hi def link nuruNumber Number
hi def link nuruFloat Float
hi def link nuruString String
hi def link nuruEscape SpecialChar
hi def link nuruComment Comment
hi def link nuruTodo Todo
hi def link nuruDelimiter Delimiter

let b:current_syntax = "nuru"

let &cpo = s:cpo_save
unlet s:cpo_save
