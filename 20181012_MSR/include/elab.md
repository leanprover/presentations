<pre class="juicy-ace-editor-container ace-chrome"><span title="(module.header [] [])"></span><span title="(command.check
 &quot;#check&quot;
 (term.app
  (term.app
   (ident_univs `list.map [])
   (term.paren
    &quot;(&quot;
    [(term.paren_content
      (term.lambda
       &quot;λ&quot;
       (term.binders [(term.binder_ident (0 `p))] [])
       &quot;,&quot;
       (term.projection
        (ident_univs `p [])
        &quot;.&quot;
        (term.projection_spec (1 (number (0 &quot;1&quot;))))))
      [])]
    &quot;)&quot;))
  (ident_univs `pairs [])))"><span class='ace_comment'></span>#check<span class='ace_comment'> </span><span title="(term.app
 (term.app
  (ident_univs `list.map [])
  (term.paren
   &quot;(&quot;
   [(term.paren_content
     (term.lambda
      &quot;λ&quot;
      (term.binders [(term.binder_ident (0 `p))] [])
      &quot;,&quot;
      (term.projection
       (ident_univs `p [])
       &quot;.&quot;
       (term.projection_spec (1 (number (0 &quot;1&quot;))))))
     [])]
   &quot;)&quot;))
 (ident_univs `pairs []))"><span title="(term.app
 (ident_univs `list.map [])
 (term.paren
  &quot;(&quot;
  [(term.paren_content
    (term.lambda
     &quot;λ&quot;
     (term.binders [(term.binder_ident (0 `p))] [])
     &quot;,&quot;
     (term.projection
      (ident_univs `p [])
      &quot;.&quot;
      (term.projection_spec (1 (number (0 &quot;1&quot;))))))
    [])]
  &quot;)&quot;))">list.map<span title="(term.paren
 &quot;(&quot;
 [(term.paren_content
   (term.lambda
    &quot;λ&quot;
    (term.binders [(term.binder_ident (0 `p))] [])
    &quot;,&quot;
    (term.projection
     (ident_univs `p [])
     &quot;.&quot;
     (term.projection_spec (1 (number (0 &quot;1&quot;))))))
   [])]
 &quot;)&quot;)"><span class='ace_comment'> </span>(<span class='ace_comment'></span><span title="(term.paren_content
 (term.lambda
  &quot;λ&quot;
  (term.binders [(term.binder_ident (0 `p))] [])
  &quot;,&quot;
  (term.projection
   (ident_univs `p [])
   &quot;.&quot;
   (term.projection_spec (1 (number (0 &quot;1&quot;))))))
 [])"><span title="(term.lambda
 &quot;λ&quot;
 (term.binders [(term.binder_ident (0 `p))] [])
 &quot;,&quot;
 (term.projection
  (ident_univs `p [])
  &quot;.&quot;
  (term.projection_spec (1 (number (0 &quot;1&quot;))))))"><span class='ace_comment'></span>λ<span class='ace_comment'> </span><span title="(term.binders [(term.binder_ident (0 `p))] [])"><span title="(term.binder_ident (0 `p))"><span class='ace_variable'>p</span></span></span><span class='ace_comment'></span>,<span class='ace_comment'> </span><span title="(term.projection
 (ident_univs `p [])
 &quot;.&quot;
 (term.projection_spec (1 (number (0 &quot;1&quot;)))))">p<span class='ace_comment'></span>.<span class='ace_comment'></span><span title="(term.projection_spec (1 (number (0 &quot;1&quot;))))"><span title="(number (0 &quot;1&quot;))"><span class='ace_comment'></span>1<span class='ace_comment'></span></span></span></span></span></span><span class='ace_comment'></span>)<span class='ace_comment'> </span></span></span>pairs</span></span><span title="(eoi &quot;&quot;)"><span class='ace_comment'>  -- invalid field notation, type of `p` is not known</span><span class='ace_comment'></span></span></pre>