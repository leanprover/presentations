<pre class="juicy-ace-editor-container ace-chrome"><span title="(module.header [] [])"></span><span title="(command.mixfix
 [[] (command.mixfix.kind (2 &quot;infixl&quot;))]
 (command.notation_spec.mixfix_symbol
  (0
   (command.notation_spec.notation_quoted_symbol
    &quot;`&quot;
    &quot;×&quot;
    &quot;`&quot;
    [(command.notation_spec.precedence
      &quot;:&quot;
      (command.notation_spec.precedence_term
       (0 (command.notation_spec.precedence_lit (0 (number (0 &quot;30&quot;)))))))])))
 &quot;:=&quot;
 (ident_univs `bla []))"><span title="(command.mixfix.kind (2 &quot;infixl&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>infixl</span><span class='ace_comment'> </span></span><span title="(command.notation_spec.mixfix_symbol
 (0
  (command.notation_spec.notation_quoted_symbol
   &quot;`&quot;
   &quot;×&quot;
   &quot;`&quot;
   [(command.notation_spec.precedence
     &quot;:&quot;
     (command.notation_spec.precedence_term
      (0 (command.notation_spec.precedence_lit (0 (number (0 &quot;30&quot;)))))))])))"><span title="(command.notation_spec.notation_quoted_symbol
 &quot;`&quot;
 &quot;×&quot;
 &quot;`&quot;
 [(command.notation_spec.precedence
   &quot;:&quot;
   (command.notation_spec.precedence_term
    (0 (command.notation_spec.precedence_lit (0 (number (0 &quot;30&quot;)))))))])"><span class='ace_comment'></span>`<span class='ace_comment'></span><span class='ace_comment'></span>×<span class='ace_comment'></span><span class='ace_comment'></span>`<span class='ace_comment'></span><span title="(command.notation_spec.precedence
 &quot;:&quot;
 (command.notation_spec.precedence_term
  (0 (command.notation_spec.precedence_lit (0 (number (0 &quot;30&quot;)))))))"><span class='ace_comment'></span>:<span class='ace_comment'></span><span title="(command.notation_spec.precedence_term
 (0 (command.notation_spec.precedence_lit (0 (number (0 &quot;30&quot;))))))"><span title="(command.notation_spec.precedence_lit (0 (number (0 &quot;30&quot;))))"><span title="(number (0 &quot;30&quot;))"><span class='ace_comment'></span>30<span class='ace_comment'> </span></span></span></span></span></span></span><span class='ace_comment'></span>:=<span class='ace_comment'> </span>bla</span><span title="(command.declaration
 (command.decl_modifiers [] [] [] [] [])
 (command.declaration.inner
  (0
   (command.def_like
    (command.def_like.kind (0 &quot;def&quot;))
    []
    `state_t'
    (command.decl_sig
     [(term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `σ))]
            [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
            [])))
         &quot;)&quot;)))
      (term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `m))]
            [(term.binder_content_type
              &quot;:&quot;
              (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
            [])))
         &quot;)&quot;)))
      (term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `α))]
            [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
            [])))
         &quot;)&quot;)))]
     [])
    (command.decl_val
     (0
      (command.simple_decl_val
       &quot;:=&quot;
       (term.arrow
        (notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))
        &quot;→&quot;
        (term.app
         (ident_univs `m [])
         (term.paren
          &quot;(&quot;
          [(term.paren_content
            (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
            [])]
          &quot;)&quot;))))))))))"><span title="(command.decl_modifiers [] [] [] [] [])"></span><span title="(command.declaration.inner
 (0
  (command.def_like
   (command.def_like.kind (0 &quot;def&quot;))
   []
   `state_t'
   (command.decl_sig
    [(term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `σ))]
           [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
           [])))
        &quot;)&quot;)))
     (term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `m))]
           [(term.binder_content_type
             &quot;:&quot;
             (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
           [])))
        &quot;)&quot;)))
     (term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `α))]
           [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
           [])))
        &quot;)&quot;)))]
    [])
   (command.decl_val
    (0
     (command.simple_decl_val
      &quot;:=&quot;
      (term.arrow
       (notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))
       &quot;→&quot;
       (term.app
        (ident_univs `m [])
        (term.paren
         &quot;(&quot;
         [(term.paren_content
           (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
           [])]
         &quot;)&quot;)))))))))"><span title="(command.def_like
 (command.def_like.kind (0 &quot;def&quot;))
 []
 `state_t'
 (command.decl_sig
  [(term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `σ))]
         [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
         [])))
      &quot;)&quot;)))
   (term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `m))]
         [(term.binder_content_type
           &quot;:&quot;
           (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
         [])))
      &quot;)&quot;)))
   (term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `α))]
         [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
         [])))
      &quot;)&quot;)))]
  [])
 (command.decl_val
  (0
   (command.simple_decl_val
    &quot;:=&quot;
    (term.arrow
     (notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))
     &quot;→&quot;
     (term.app
      (ident_univs `m [])
      (term.paren
       &quot;(&quot;
       [(term.paren_content
         (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
         [])]
       &quot;)&quot;)))))))"><span title="(command.def_like.kind (0 &quot;def&quot;))"><span class='ace_comment'>
</span><span class='ace_keyword'>def</span><span class='ace_comment'> </span></span><span class='ace_variable'>state_t'</span><span title="(command.decl_sig
 [(term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `σ))]
        [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
        [])))
     &quot;)&quot;)))
  (term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `m))]
        [(term.binder_content_type
          &quot;:&quot;
          (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
        [])))
     &quot;)&quot;)))
  (term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `α))]
        [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
        [])))
     &quot;)&quot;)))]
 [])"><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `σ))]
      [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `σ))]
    [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `σ))]
   [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `σ))]
 [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
 [])"><span title="(term.binder_ident (0 `σ))"><span class='ace_variable'>σ</span></span><span title="(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `m))]
      [(term.binder_content_type
        &quot;:&quot;
        (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `m))]
    [(term.binder_content_type
      &quot;:&quot;
      (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'></span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `m))]
   [(term.binder_content_type
     &quot;:&quot;
     (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `m))]
 [(term.binder_content_type
   &quot;:&quot;
   (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
 [])"><span title="(term.binder_ident (0 `m))"><span class='ace_variable'>m</span></span><span title="(term.binder_content_type
 &quot;:&quot;
 (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;)))"><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'> </span></span><span class='ace_comment'></span>→<span class='ace_comment'> </span><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'></span></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `α))]
      [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `α))]
    [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'></span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `α))]
   [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `α))]
 [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
 [])"><span title="(term.binder_ident (0 `α))"><span class='ace_variable'>α</span></span><span title="(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span></span><span title="(command.decl_val
 (0
  (command.simple_decl_val
   &quot;:=&quot;
   (term.arrow
    (notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))
    &quot;→&quot;
    (term.app
     (ident_univs `m [])
     (term.paren
      &quot;(&quot;
      [(term.paren_content
        (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
        [])]
      &quot;)&quot;))))))"><span title="(command.simple_decl_val
 &quot;:=&quot;
 (term.arrow
  (notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))
  &quot;→&quot;
  (term.app
   (ident_univs `m [])
   (term.paren
    &quot;(&quot;
    [(term.paren_content
      (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
      [])]
    &quot;)&quot;))))"><span class='ace_comment'></span>:=<span class='ace_comment'>
</span><span title="(term.arrow
 (notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))
 &quot;→&quot;
 (term.app
  (ident_univs `m [])
  (term.paren
   &quot;(&quot;
   [(term.paren_content
     (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
     [])]
   &quot;)&quot;)))"><span title="(notation<TODO> (ident_univs `unit []) &quot;×&quot; (ident_univs `σ []))">unit<span class='ace_comment'> </span>×<span class='ace_comment'> </span>σ</span><span class='ace_comment'> </span>→<span class='ace_comment'> </span><span title="(term.app
 (ident_univs `m [])
 (term.paren
  &quot;(&quot;
  [(term.paren_content
    (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
    [])]
  &quot;)&quot;))">m<span title="(term.paren
 &quot;(&quot;
 [(term.paren_content
   (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
   [])]
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.paren_content
 (notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))
 [])"><span title="(notation<TODO> (ident_univs `α []) &quot;×&quot; (ident_univs `σ []))">α<span class='ace_comment'> </span>×<span class='ace_comment'> </span>σ</span></span><span class='ace_comment'></span>)<span class='ace_comment'>

</span></span></span></span></span></span></span></span></span><span title="(command.declaration
 (command.decl_modifiers [] [] [] [] [])
 (command.declaration.inner
  (0
   (command.def_like
    (command.def_like.kind (0 &quot;def&quot;))
    []
    `except_t'
    (command.decl_sig
     [(term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `ε))]
            [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
            [])))
         &quot;)&quot;)))
      (term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `m))]
            [(term.binder_content_type
              &quot;:&quot;
              (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
            [])))
         &quot;)&quot;)))
      (term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `α))]
            [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
            [])))
         &quot;)&quot;)))]
     [])
    (command.decl_val
     (0
      (command.simple_decl_val
       &quot;:=&quot;
       (term.arrow
        (term.app
         (term.app (ident_univs `except []) (ident_univs `empty []))
         (ident_univs `unit []))
        &quot;→&quot;
        (term.app
         (ident_univs `m [])
         (term.paren
          &quot;(&quot;
          [(term.paren_content
            (term.app
             (term.app (ident_univs `except []) (ident_univs `ε []))
             (ident_univs `α []))
            [])]
          &quot;)&quot;))))))))))"><span title="(command.decl_modifiers [] [] [] [] [])"></span><span title="(command.declaration.inner
 (0
  (command.def_like
   (command.def_like.kind (0 &quot;def&quot;))
   []
   `except_t'
   (command.decl_sig
    [(term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `ε))]
           [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
           [])))
        &quot;)&quot;)))
     (term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `m))]
           [(term.binder_content_type
             &quot;:&quot;
             (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
           [])))
        &quot;)&quot;)))
     (term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `α))]
           [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
           [])))
        &quot;)&quot;)))]
    [])
   (command.decl_val
    (0
     (command.simple_decl_val
      &quot;:=&quot;
      (term.arrow
       (term.app
        (term.app (ident_univs `except []) (ident_univs `empty []))
        (ident_univs `unit []))
       &quot;→&quot;
       (term.app
        (ident_univs `m [])
        (term.paren
         &quot;(&quot;
         [(term.paren_content
           (term.app
            (term.app (ident_univs `except []) (ident_univs `ε []))
            (ident_univs `α []))
           [])]
         &quot;)&quot;)))))))))"><span title="(command.def_like
 (command.def_like.kind (0 &quot;def&quot;))
 []
 `except_t'
 (command.decl_sig
  [(term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `ε))]
         [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
         [])))
      &quot;)&quot;)))
   (term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `m))]
         [(term.binder_content_type
           &quot;:&quot;
           (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
         [])))
      &quot;)&quot;)))
   (term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `α))]
         [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
         [])))
      &quot;)&quot;)))]
  [])
 (command.decl_val
  (0
   (command.simple_decl_val
    &quot;:=&quot;
    (term.arrow
     (term.app
      (term.app (ident_univs `except []) (ident_univs `empty []))
      (ident_univs `unit []))
     &quot;→&quot;
     (term.app
      (ident_univs `m [])
      (term.paren
       &quot;(&quot;
       [(term.paren_content
         (term.app
          (term.app (ident_univs `except []) (ident_univs `ε []))
          (ident_univs `α []))
         [])]
       &quot;)&quot;)))))))"><span title="(command.def_like.kind (0 &quot;def&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>def</span><span class='ace_comment'> </span></span><span class='ace_variable'>except_t'</span><span title="(command.decl_sig
 [(term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `ε))]
        [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
        [])))
     &quot;)&quot;)))
  (term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `m))]
        [(term.binder_content_type
          &quot;:&quot;
          (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
        [])))
     &quot;)&quot;)))
  (term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `α))]
        [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
        [])))
     &quot;)&quot;)))]
 [])"><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `ε))]
      [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `ε))]
    [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `ε))]
   [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `ε))]
 [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
 [])"><span title="(term.binder_ident (0 `ε))"><span class='ace_variable'>ε</span></span><span title="(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `m))]
      [(term.binder_content_type
        &quot;:&quot;
        (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `m))]
    [(term.binder_content_type
      &quot;:&quot;
      (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'></span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `m))]
   [(term.binder_content_type
     &quot;:&quot;
     (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `m))]
 [(term.binder_content_type
   &quot;:&quot;
   (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))]
 [])"><span title="(term.binder_ident (0 `m))"><span class='ace_variable'>m</span></span><span title="(term.binder_content_type
 &quot;:&quot;
 (term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;))))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.arrow (term.sort (1 &quot;Type&quot;)) &quot;→&quot; (term.sort (1 &quot;Type&quot;)))"><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'> </span></span><span class='ace_comment'></span>→<span class='ace_comment'> </span><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'></span></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `α))]
      [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `α))]
    [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'></span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `α))]
   [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `α))]
 [(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))]
 [])"><span title="(term.binder_ident (0 `α))"><span class='ace_variable'>α</span></span><span title="(term.binder_content_type &quot;:&quot; (term.sort (1 &quot;Type&quot;)))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.sort (1 &quot;Type&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>Type</span><span class='ace_comment'></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span></span><span title="(command.decl_val
 (0
  (command.simple_decl_val
   &quot;:=&quot;
   (term.arrow
    (term.app
     (term.app (ident_univs `except []) (ident_univs `empty []))
     (ident_univs `unit []))
    &quot;→&quot;
    (term.app
     (ident_univs `m [])
     (term.paren
      &quot;(&quot;
      [(term.paren_content
        (term.app
         (term.app (ident_univs `except []) (ident_univs `ε []))
         (ident_univs `α []))
        [])]
      &quot;)&quot;))))))"><span title="(command.simple_decl_val
 &quot;:=&quot;
 (term.arrow
  (term.app
   (term.app (ident_univs `except []) (ident_univs `empty []))
   (ident_univs `unit []))
  &quot;→&quot;
  (term.app
   (ident_univs `m [])
   (term.paren
    &quot;(&quot;
    [(term.paren_content
      (term.app
       (term.app (ident_univs `except []) (ident_univs `ε []))
       (ident_univs `α []))
      [])]
    &quot;)&quot;))))"><span class='ace_comment'></span>:=<span class='ace_comment'>
</span><span title="(term.arrow
 (term.app
  (term.app (ident_univs `except []) (ident_univs `empty []))
  (ident_univs `unit []))
 &quot;→&quot;
 (term.app
  (ident_univs `m [])
  (term.paren
   &quot;(&quot;
   [(term.paren_content
     (term.app
      (term.app (ident_univs `except []) (ident_univs `ε []))
      (ident_univs `α []))
     [])]
   &quot;)&quot;)))"><span title="(term.app
 (term.app (ident_univs `except []) (ident_univs `empty []))
 (ident_univs `unit []))"><span title="(term.app (ident_univs `except []) (ident_univs `empty []))">except empty</span> unit</span><span class='ace_comment'> </span>→<span class='ace_comment'> </span><span title="(term.app
 (ident_univs `m [])
 (term.paren
  &quot;(&quot;
  [(term.paren_content
    (term.app
     (term.app (ident_univs `except []) (ident_univs `ε []))
     (ident_univs `α []))
    [])]
  &quot;)&quot;))">m<span title="(term.paren
 &quot;(&quot;
 [(term.paren_content
   (term.app
    (term.app (ident_univs `except []) (ident_univs `ε []))
    (ident_univs `α []))
   [])]
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.paren_content
 (term.app
  (term.app (ident_univs `except []) (ident_univs `ε []))
  (ident_univs `α []))
 [])"><span title="(term.app
 (term.app (ident_univs `except []) (ident_univs `ε []))
 (ident_univs `α []))"><span title="(term.app (ident_univs `except []) (ident_univs `ε []))">except ε</span> α</span></span><span class='ace_comment'></span>)<span class='ace_comment'></span></span></span></span></span></span></span></span></span><span title="(eoi &quot;&quot;)"><span class='ace_comment'></span><span class='ace_comment'></span></span></pre>