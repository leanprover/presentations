<pre class="juicy-ace-editor-container ace-chrome"><span title="(module.header [] [])"></span><span title="(command.declaration
 (command.decl_modifiers [] [] [] [] [])
 (command.declaration.inner
  (0
   (command.def_like
    (command.def_like.kind (0 &quot;def&quot;))
    []
    `state_t.pure
    (command.decl_sig
     [(term.bracketed_binder
       (0
        (term.explicit_binder
         &quot;(&quot;
         (term.explicit_binder_content
          (1
           (term.binder_content
            [(term.binder_ident (0 `a))]
            [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
            [])))
         &quot;)&quot;)))]
     [(command.decl_type
       &quot;:&quot;
       (term.app
        (term.app
         (term.app (ident_univs `state_t []) (ident_univs `ρ []))
         (ident_univs `m []))
        (ident_univs `α [])))])
    (command.decl_val
     (0
      (command.simple_decl_val
       &quot;:=&quot;
       (term.lambda
        &quot;λ&quot;
        (term.binders [(term.binder_ident (0 `s))] [])
        &quot;,&quot;
        (term.app
         (ident_univs `pure [])
         (term.paren
          &quot;(&quot;
          [(term.paren_content
            (ident_univs `a [])
            [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
          &quot;)&quot;))))))))))"><span title="(command.decl_modifiers [] [] [] [] [])"></span><span title="(command.declaration.inner
 (0
  (command.def_like
   (command.def_like.kind (0 &quot;def&quot;))
   []
   `state_t.pure
   (command.decl_sig
    [(term.bracketed_binder
      (0
       (term.explicit_binder
        &quot;(&quot;
        (term.explicit_binder_content
         (1
          (term.binder_content
           [(term.binder_ident (0 `a))]
           [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
           [])))
        &quot;)&quot;)))]
    [(command.decl_type
      &quot;:&quot;
      (term.app
       (term.app
        (term.app (ident_univs `state_t []) (ident_univs `ρ []))
        (ident_univs `m []))
       (ident_univs `α [])))])
   (command.decl_val
    (0
     (command.simple_decl_val
      &quot;:=&quot;
      (term.lambda
       &quot;λ&quot;
       (term.binders [(term.binder_ident (0 `s))] [])
       &quot;,&quot;
       (term.app
        (ident_univs `pure [])
        (term.paren
         &quot;(&quot;
         [(term.paren_content
           (ident_univs `a [])
           [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
         &quot;)&quot;)))))))))"><span title="(command.def_like
 (command.def_like.kind (0 &quot;def&quot;))
 []
 `state_t.pure
 (command.decl_sig
  [(term.bracketed_binder
    (0
     (term.explicit_binder
      &quot;(&quot;
      (term.explicit_binder_content
       (1
        (term.binder_content
         [(term.binder_ident (0 `a))]
         [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
         [])))
      &quot;)&quot;)))]
  [(command.decl_type
    &quot;:&quot;
    (term.app
     (term.app
      (term.app (ident_univs `state_t []) (ident_univs `ρ []))
      (ident_univs `m []))
     (ident_univs `α [])))])
 (command.decl_val
  (0
   (command.simple_decl_val
    &quot;:=&quot;
    (term.lambda
     &quot;λ&quot;
     (term.binders [(term.binder_ident (0 `s))] [])
     &quot;,&quot;
     (term.app
      (ident_univs `pure [])
      (term.paren
       &quot;(&quot;
       [(term.paren_content
         (ident_univs `a [])
         [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
       &quot;)&quot;)))))))"><span title="(command.def_like.kind (0 &quot;def&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>def</span><span class='ace_comment'> </span></span><span class='ace_variable'>state_t.pure</span><span title="(command.decl_sig
 [(term.bracketed_binder
   (0
    (term.explicit_binder
     &quot;(&quot;
     (term.explicit_binder_content
      (1
       (term.binder_content
        [(term.binder_ident (0 `a))]
        [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
        [])))
     &quot;)&quot;)))]
 [(command.decl_type
   &quot;:&quot;
   (term.app
    (term.app
     (term.app (ident_univs `state_t []) (ident_univs `ρ []))
     (ident_univs `m []))
    (ident_univs `α [])))])"><span title="(term.bracketed_binder
 (0
  (term.explicit_binder
   &quot;(&quot;
   (term.explicit_binder_content
    (1
     (term.binder_content
      [(term.binder_ident (0 `a))]
      [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
      [])))
   &quot;)&quot;)))"><span title="(term.explicit_binder
 &quot;(&quot;
 (term.explicit_binder_content
  (1
   (term.binder_content
    [(term.binder_ident (0 `a))]
    [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
    [])))
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.explicit_binder_content
 (1
  (term.binder_content
   [(term.binder_ident (0 `a))]
   [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
   [])))"><span title="(term.binder_content
 [(term.binder_ident (0 `a))]
 [(term.binder_content_type &quot;:&quot; (ident_univs `α []))]
 [])"><span title="(term.binder_ident (0 `a))"><span class='ace_variable'>a</span></span><span title="(term.binder_content_type &quot;:&quot; (ident_univs `α []))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span>α</span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span><span title="(command.decl_type
 &quot;:&quot;
 (term.app
  (term.app
   (term.app (ident_univs `state_t []) (ident_univs `ρ []))
   (ident_univs `m []))
  (ident_univs `α [])))"><span class='ace_comment'></span>:<span class='ace_comment'> </span><span title="(term.app
 (term.app
  (term.app (ident_univs `state_t []) (ident_univs `ρ []))
  (ident_univs `m []))
 (ident_univs `α []))"><span title="(term.app
 (term.app (ident_univs `state_t []) (ident_univs `ρ []))
 (ident_univs `m []))"><span title="(term.app (ident_univs `state_t []) (ident_univs `ρ []))">state_t ρ</span> m</span> α</span></span></span><span title="(command.decl_val
 (0
  (command.simple_decl_val
   &quot;:=&quot;
   (term.lambda
    &quot;λ&quot;
    (term.binders [(term.binder_ident (0 `s))] [])
    &quot;,&quot;
    (term.app
     (ident_univs `pure [])
     (term.paren
      &quot;(&quot;
      [(term.paren_content
        (ident_univs `a [])
        [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
      &quot;)&quot;))))))"><span title="(command.simple_decl_val
 &quot;:=&quot;
 (term.lambda
  &quot;λ&quot;
  (term.binders [(term.binder_ident (0 `s))] [])
  &quot;,&quot;
  (term.app
   (ident_univs `pure [])
   (term.paren
    &quot;(&quot;
    [(term.paren_content
      (ident_univs `a [])
      [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
    &quot;)&quot;))))"><span class='ace_comment'> </span>:=<span class='ace_comment'>
</span><span title="(term.lambda
 &quot;λ&quot;
 (term.binders [(term.binder_ident (0 `s))] [])
 &quot;,&quot;
 (term.app
  (ident_univs `pure [])
  (term.paren
   &quot;(&quot;
   [(term.paren_content
     (ident_univs `a [])
     [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
   &quot;)&quot;)))"><span class='ace_comment'></span>λ<span class='ace_comment'> </span><span title="(term.binders [(term.binder_ident (0 `s))] [])"><span title="(term.binder_ident (0 `s))"><span class='ace_variable'>s</span></span></span><span class='ace_comment'></span>,<span class='ace_comment'> </span><span title="(term.app
 (ident_univs `pure [])
 (term.paren
  &quot;(&quot;
  [(term.paren_content
    (ident_univs `a [])
    [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
  &quot;)&quot;))">pure<span title="(term.paren
 &quot;(&quot;
 [(term.paren_content
   (ident_univs `a [])
   [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])]
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.paren_content
 (ident_univs `a [])
 [(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))])">a<span title="(term.paren_special (0 (term.tuple &quot;,&quot; [(ident_univs `s [])])))"><span title="(term.tuple &quot;,&quot; [(ident_univs `s [])])"><span class='ace_comment'></span>,<span class='ace_comment'> </span>s</span></span></span><span class='ace_comment'></span>)<span class='ace_comment'>

</span></span></span></span></span></span></span></span></span><span title="(command.declaration
 (command.decl_modifiers [] [] [] [] [])
 (command.declaration.inner
  (0
   (command.def_like
    (command.def_like.kind (0 &quot;def&quot;))
    []
    `test
    (command.decl_sig
     []
     [(command.decl_type
       &quot;:&quot;
       (term.app
        (term.app
         (term.app (ident_univs `state_t []) (ident_univs `nat []))
         (ident_univs `io []))
        (ident_univs `nat [])))])
    (command.decl_val
     (0
      (command.simple_decl_val
       &quot;:=&quot;
       (term.app (ident_univs `pure []) (number (0 &quot;10&quot;))))))))))"><span title="(command.decl_modifiers [] [] [] [] [])"></span><span title="(command.declaration.inner
 (0
  (command.def_like
   (command.def_like.kind (0 &quot;def&quot;))
   []
   `test
   (command.decl_sig
    []
    [(command.decl_type
      &quot;:&quot;
      (term.app
       (term.app
        (term.app (ident_univs `state_t []) (ident_univs `nat []))
        (ident_univs `io []))
       (ident_univs `nat [])))])
   (command.decl_val
    (0
     (command.simple_decl_val
      &quot;:=&quot;
      (term.app (ident_univs `pure []) (number (0 &quot;10&quot;)))))))))"><span title="(command.def_like
 (command.def_like.kind (0 &quot;def&quot;))
 []
 `test
 (command.decl_sig
  []
  [(command.decl_type
    &quot;:&quot;
    (term.app
     (term.app
      (term.app (ident_univs `state_t []) (ident_univs `nat []))
      (ident_univs `io []))
     (ident_univs `nat [])))])
 (command.decl_val
  (0
   (command.simple_decl_val
    &quot;:=&quot;
    (term.app (ident_univs `pure []) (number (0 &quot;10&quot;)))))))"><span title="(command.def_like.kind (0 &quot;def&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>def</span><span class='ace_comment'> </span></span><span class='ace_variable'>test</span><span title="(command.decl_sig
 []
 [(command.decl_type
   &quot;:&quot;
   (term.app
    (term.app
     (term.app (ident_univs `state_t []) (ident_univs `nat []))
     (ident_univs `io []))
    (ident_univs `nat [])))])"><span title="(command.decl_type
 &quot;:&quot;
 (term.app
  (term.app
   (term.app (ident_univs `state_t []) (ident_univs `nat []))
   (ident_univs `io []))
  (ident_univs `nat [])))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.app
 (term.app
  (term.app (ident_univs `state_t []) (ident_univs `nat []))
  (ident_univs `io []))
 (ident_univs `nat []))"><span title="(term.app
 (term.app (ident_univs `state_t []) (ident_univs `nat []))
 (ident_univs `io []))"><span title="(term.app (ident_univs `state_t []) (ident_univs `nat []))">state_t nat</span> io</span> nat</span></span></span><span title="(command.decl_val
 (0
  (command.simple_decl_val
   &quot;:=&quot;
   (term.app (ident_univs `pure []) (number (0 &quot;10&quot;))))))"><span title="(command.simple_decl_val
 &quot;:=&quot;
 (term.app (ident_univs `pure []) (number (0 &quot;10&quot;))))"><span class='ace_comment'> </span>:=<span class='ace_comment'>
</span><span title="(term.app (ident_univs `pure []) (number (0 &quot;10&quot;)))">pure<span title="(number (0 &quot;10&quot;))"><span class='ace_comment'> </span>10<span class='ace_comment'>

-- eta expansion
</span></span></span></span></span></span></span></span><span title="(command.declaration
 (command.decl_modifiers [] [] [] [] [])
 (command.declaration.inner
  (0
   (command.def_like
    (command.def_like.kind (0 &quot;def&quot;))
    []
    `test'
    (command.decl_sig
     []
     [(command.decl_type
       &quot;:&quot;
       (term.app
        (term.app
         (term.app (ident_univs `state_t []) (ident_univs `nat []))
         (ident_univs `io []))
        (ident_univs `nat [])))])
    (command.decl_val
     (0
      (command.simple_decl_val
       &quot;:=&quot;
       (term.lambda
        &quot;λ&quot;
        (term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])
        &quot;,&quot;
        (term.app
         (term.app
          (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
          (ident_univs `r []))
         (ident_univs `world []))))))))))"><span title="(command.decl_modifiers [] [] [] [] [])"></span><span title="(command.declaration.inner
 (0
  (command.def_like
   (command.def_like.kind (0 &quot;def&quot;))
   []
   `test'
   (command.decl_sig
    []
    [(command.decl_type
      &quot;:&quot;
      (term.app
       (term.app
        (term.app (ident_univs `state_t []) (ident_univs `nat []))
        (ident_univs `io []))
       (ident_univs `nat [])))])
   (command.decl_val
    (0
     (command.simple_decl_val
      &quot;:=&quot;
      (term.lambda
       &quot;λ&quot;
       (term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])
       &quot;,&quot;
       (term.app
        (term.app
         (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
         (ident_univs `r []))
        (ident_univs `world [])))))))))"><span title="(command.def_like
 (command.def_like.kind (0 &quot;def&quot;))
 []
 `test'
 (command.decl_sig
  []
  [(command.decl_type
    &quot;:&quot;
    (term.app
     (term.app
      (term.app (ident_univs `state_t []) (ident_univs `nat []))
      (ident_univs `io []))
     (ident_univs `nat [])))])
 (command.decl_val
  (0
   (command.simple_decl_val
    &quot;:=&quot;
    (term.lambda
     &quot;λ&quot;
     (term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])
     &quot;,&quot;
     (term.app
      (term.app
       (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
       (ident_univs `r []))
      (ident_univs `world [])))))))"><span title="(command.def_like.kind (0 &quot;def&quot;))"><span class='ace_comment'></span><span class='ace_keyword'>def</span><span class='ace_comment'> </span></span><span class='ace_variable'>test'</span><span title="(command.decl_sig
 []
 [(command.decl_type
   &quot;:&quot;
   (term.app
    (term.app
     (term.app (ident_univs `state_t []) (ident_univs `nat []))
     (ident_univs `io []))
    (ident_univs `nat [])))])"><span title="(command.decl_type
 &quot;:&quot;
 (term.app
  (term.app
   (term.app (ident_univs `state_t []) (ident_univs `nat []))
   (ident_univs `io []))
  (ident_univs `nat [])))"><span class='ace_comment'> </span>:<span class='ace_comment'> </span><span title="(term.app
 (term.app
  (term.app (ident_univs `state_t []) (ident_univs `nat []))
  (ident_univs `io []))
 (ident_univs `nat []))"><span title="(term.app
 (term.app (ident_univs `state_t []) (ident_univs `nat []))
 (ident_univs `io []))"><span title="(term.app (ident_univs `state_t []) (ident_univs `nat []))">state_t nat</span> io</span> nat</span></span></span><span title="(command.decl_val
 (0
  (command.simple_decl_val
   &quot;:=&quot;
   (term.lambda
    &quot;λ&quot;
    (term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])
    &quot;,&quot;
    (term.app
     (term.app
      (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
      (ident_univs `r []))
     (ident_univs `world []))))))"><span title="(command.simple_decl_val
 &quot;:=&quot;
 (term.lambda
  &quot;λ&quot;
  (term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])
  &quot;,&quot;
  (term.app
   (term.app
    (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
    (ident_univs `r []))
   (ident_univs `world []))))"><span class='ace_comment'> </span>:=<span class='ace_comment'>
</span><span title="(term.lambda
 &quot;λ&quot;
 (term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])
 &quot;,&quot;
 (term.app
  (term.app
   (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
   (ident_univs `r []))
  (ident_univs `world [])))"><span class='ace_comment'></span>λ<span class='ace_comment'> </span><span title="(term.binders [(term.binder_ident (0 `r)) (term.binder_ident (0 `world))] [])"><span title="(term.binder_ident (0 `r))"><span class='ace_variable'>r</span></span><span title="(term.binder_ident (0 `world))"><span class='ace_variable'> world</span></span></span><span class='ace_comment'></span>,<span class='ace_comment'> </span><span title="(term.app
 (term.app
  (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
  (ident_univs `r []))
 (ident_univs `world []))"><span title="(term.app
 (term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))
 (ident_univs `r []))"><span title="(term.app (ident_univs `state_t.pure []) (number (0 &quot;10&quot;)))">state_t.pure<span title="(number (0 &quot;10&quot;))"><span class='ace_comment'> </span>10<span class='ace_comment'> </span></span></span>r</span> world</span></span></span></span></span></span></span><span title="(eoi &quot;&quot;)"><span class='ace_comment'>
</span><span class='ace_comment'></span></span></pre>