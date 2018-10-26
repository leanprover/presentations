<pre class="juicy-ace-editor-container ace-chrome"><span title="(module.header [] [])"></span><span title="(command.declaration
 (command.decl_modifiers
  []
  [(command.decl_attribute
    &quot;@[&quot;
    [(command.attr_instance
      `derive
      [(term.app (ident_univs `parser.has_tokens []) (ident_univs `parser.has_view []))])]
    &quot;]&quot;)]
  []
  []
  [])
 (command.declaration.inner
  (0
   (command.def_like
    (command.def_like.kind (0 &quot;def&quot;))
    []
    `anonymous_constructor.parser
    (command.decl_sig [] [(command.decl_type &quot;:&quot; (ident_univs `term_parser []))])
    (command.decl_val
     (0
      (command.simple_decl_val
       &quot;:=&quot;
       (node_macro
        &quot;node!&quot;
        `anonymous_constructor
        &quot;[&quot;
        [(node.content
          (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))
         &quot;,&quot;
         (node.content
          (1
           (ncp
            `args
            &quot;:&quot;
            (term.app
             (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
             (term.paren
              &quot;(&quot;
              [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
              &quot;)&quot;)))))
         &quot;,&quot;
         (node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))]
        &quot;]&quot;))))))))"><span title="(command.decl_modifiers
 []
 [(command.decl_attribute
   &quot;@[&quot;
   [(command.attr_instance
     `derive
     [(term.app (ident_univs `parser.has_tokens []) (ident_univs `parser.has_view []))])]
   &quot;]&quot;)]
 []
 []
 [])"><span title="(command.decl_attribute
 &quot;@[&quot;
 [(command.attr_instance
   `derive
   [(term.app (ident_univs `parser.has_tokens []) (ident_univs `parser.has_view []))])]
 &quot;]&quot;)"><span class='ace_comment'>
</span>@[<span class='ace_comment'></span><span title="(command.attr_instance
 `derive
 [(term.app
   (ident_univs `parser.has_tokens [])
   (ident_univs `parser.has_view []))])"><span class='ace_variable'>derive</span><span title="(term.app (ident_univs `parser.has_tokens []) (ident_univs `parser.has_view []))"> parser.has_tokens parser.has_view</span></span><span class='ace_comment'></span>]<span class='ace_comment'>
</span></span></span><span title="(command.declaration.inner
 (0
  (command.def_like
   (command.def_like.kind (0 &quot;def&quot;))
   []
   `anonymous_constructor.parser
   (command.decl_sig [] [(command.decl_type &quot;:&quot; (ident_univs `term_parser []))])
   (command.decl_val
    (0
     (command.simple_decl_val
      &quot;:=&quot;
      (node_macro
       &quot;node!&quot;
       `anonymous_constructor
       &quot;[&quot;
       [(node.content
         (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))
        &quot;,&quot;
        (node.content
         (1
          (ncp
           `args
           &quot;:&quot;
           (term.app
            (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
            (term.paren
             &quot;(&quot;
             [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
             &quot;)&quot;)))))
        &quot;,&quot;
        (node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))]
       &quot;]&quot;)))))))"><span title="(command.def_like
 (command.def_like.kind (0 &quot;def&quot;))
 []
 `anonymous_constructor.parser
 (command.decl_sig [] [(command.decl_type &quot;:&quot; (ident_univs `term_parser []))])
 (command.decl_val
  (0
   (command.simple_decl_val
    &quot;:=&quot;
    (node_macro
     &quot;node!&quot;
     `anonymous_constructor
     &quot;[&quot;
     [(node.content
       (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))
      &quot;,&quot;
      (node.content
       (1
        (ncp
         `args
         &quot;:&quot;
         (term.app
          (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
          (term.paren
           &quot;(&quot;
           [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
           &quot;)&quot;)))))
      &quot;,&quot;
      (node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))]
     &quot;]&quot;)))))"><span title="(command.def_like.kind (0 &quot;def&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>def</span><span class='ace_comment'> </span></span><span class='ace_variable'>anonymous_constructor.parser</span><span title="(command.decl_sig [] [(command.decl_type &quot;:&quot; (ident_univs `term_parser []))])"><span title="(command.decl_type &quot;:&quot; (ident_univs `term_parser []))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span>term_parser</span></span><span title="(command.decl_val
 (0
  (command.simple_decl_val
   &quot;:=&quot;
   (node_macro
    &quot;node!&quot;
    `anonymous_constructor
    &quot;[&quot;
    [(node.content
      (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))
     &quot;,&quot;
     (node.content
      (1
       (ncp
        `args
        &quot;:&quot;
        (term.app
         (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
         (term.paren
          &quot;(&quot;
          [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
          &quot;)&quot;)))))
     &quot;,&quot;
     (node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))]
    &quot;]&quot;))))"><span title="(command.simple_decl_val
 &quot;:=&quot;
 (node_macro
  &quot;node!&quot;
  `anonymous_constructor
  &quot;[&quot;
  [(node.content
    (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))
   &quot;,&quot;
   (node.content
    (1
     (ncp
      `args
      &quot;:&quot;
      (term.app
       (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
       (term.paren
        &quot;(&quot;
        [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
        &quot;)&quot;)))))
   &quot;,&quot;
   (node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))]
  &quot;]&quot;))"><span class='ace_comment'> </span>:=<span class='ace_comment'>
</span><span title="(node_macro
 &quot;node!&quot;
 `anonymous_constructor
 &quot;[&quot;
 [(node.content
   (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))
  &quot;,&quot;
  (node.content
   (1
    (ncp
     `args
     &quot;:&quot;
     (term.app
      (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
      (term.paren
       &quot;(&quot;
       [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
       &quot;)&quot;)))))
  &quot;,&quot;
  (node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))]
 &quot;]&quot;)"><span class='ace_comment'></span><span class='ace_keyword'>node!</span><span class='ace_comment'> </span><span class='ace_variable'>anonymous_constructor</span><span class='ace_comment'> </span>[<span class='ace_comment'></span><span title="(node.content
 (0 (ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])))"><span title="(ncs (string_lit &quot;\&quot;⟨\&quot;&quot;) [(node_prec &quot;:&quot; (ident_univs `max_prec []))])"><span class='ace_string'>"⟨"</span><span title="(node_prec &quot;:&quot; (ident_univs `max_prec []))"><span class='ace_comment'></span>:<span class='ace_comment'></span>max_prec</span></span></span><span class='ace_comment'></span>,<span class='ace_comment'> </span><span title="(node.content
 (1
  (ncp
   `args
   &quot;:&quot;
   (term.app
    (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
    (term.paren
     &quot;(&quot;
     [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
     &quot;)&quot;)))))"><span title="(ncp
 `args
 &quot;:&quot;
 (term.app
  (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
  (term.paren
   &quot;(&quot;
   [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
   &quot;)&quot;)))"><span class='ace_variable'>args</span><span class='ace_comment'></span>:<span class='ace_comment'> </span><span title="(term.app
 (term.app (ident_univs `sep_by []) (ident_univs `term.parser []))
 (term.paren
  &quot;(&quot;
  [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
  &quot;)&quot;))"><span title="(term.app (ident_univs `sep_by []) (ident_univs `term.parser []))">sep_by term.parser</span><span title="(term.paren
 &quot;(&quot;
 [(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])]
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.paren_content (term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;)) [])"><span title="(term.app (ident_univs `symbol []) (string_lit &quot;\&quot;,\&quot;&quot;))">symbol<span class='ace_string'> ","</span></span></span><span class='ace_comment'></span>)<span class='ace_comment'></span></span></span></span></span><span class='ace_comment'></span>,<span class='ace_comment'> </span><span title="(node.content (0 (ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])))"><span title="(ncs (string_lit &quot;\&quot;⟩\&quot;&quot;) [])"><span class='ace_string'>"⟩"</span></span></span><span class='ace_comment'></span>]<span class='ace_comment'>
</span></span></span></span></span></span></span></pre>