
window.onload = () => {

    // Don't show hovers inside of closed tactic states
    function blockedByTactic(elem) {
      let parent = elem.parentNode;
      while (parent && "classList" in parent) {
        if (parent.classList.contains("tactic")) {
          const toggle = parent.querySelector("input.tactic-toggle");
          if (toggle) {
            return !toggle.checked;
          }
        }
        parent = parent.parentNode;
      }
      return false;
    }

    // Track whether any tippy is visible (O(1) check instead of DOM scan)
    let visibleTippyCount = 0;
    function blockedByTippy(elem) {
      return visibleTippyCount > 0;
    }

    // Binding highlights via event delegation with cached lookups
    const bindingCache = new Map(); // context+binding -> [token elements]
    let highlightedTokens = [];
    function getBindingTokens(context, binding) {
      const key = context + "\0" + binding;
      let tokens = bindingCache.get(key);
      if (!tokens) {
        tokens = [];
        for (const example of document.querySelectorAll(".hl.lean")) {
          if (example.dataset.leanContext == context) {
            for (const tok of example.querySelectorAll(".token[data-binding=\"" + CSS.escape(binding) + "\"]")) {
              tokens.push(tok);
            }
          }
        }
        bindingCache.set(key, tokens);
      }
      return tokens;
    }
    for (const container of document.querySelectorAll(".hl.lean")) {
      container.addEventListener("mouseover", (event) => {
        const c = event.target.closest(".token");
        if (!c || !c.dataset.binding || c.dataset.binding === "" || !container.contains(c)) return;
        if (blockedByTactic(c)) return;
        const tokens = getBindingTokens(container.dataset.leanContext, c.dataset.binding);
        for (const tok of tokens) {
          tok.classList.add("binding-hl");
        }
        highlightedTokens = tokens;
      });
      container.addEventListener("mouseout", (event) => {
        const c = event.target.closest(".token");
        if (!c || !container.contains(c)) return;
        for (const tok of highlightedTokens) {
          tok.classList.remove("binding-hl");
        }
        highlightedTokens = [];
      });
    }
    /* Render docstrings */
    if ('undefined' !== typeof marked) {
        for (const d of document.querySelectorAll("code.docstring, pre.docstring")) {
            const str = d.innerText;
            const html = marked.parse(str);
            const rendered = document.createElement("div");
            rendered.classList.add("docstring");
            rendered.innerHTML = html;
            d.parentNode.replaceChild(rendered, d);
        }
    }
    // Add hovers
    let docsJson = "-verso-docs.json";
    fetch(docsJson).then((resp) => resp.json()).then((versoDocData) => {

      function hideParentTooltips(element) {
        let parent = element.parentElement;
        while (parent) {
          const tippyInstance = parent._tippy;
          if (tippyInstance) {
            tippyInstance.hide();
          }
          parent = parent.parentElement;
        }
      }



      const defaultTippyProps = {
        /* DEBUG -- remove the space: * /
        onHide(any) { return false; },
        trigger: "click",
        // */
        /* theme: "lean", */
        maxWidth: "none",
        appendTo: () => document.body,
        interactive: true,
        delay: [100, null],
        /* ignoreAttributes: true, */
        followCursor: 'initial',
        onShow(inst) {
          if (inst.reference.className == 'tactic') {
            const toggle = inst.reference.querySelector("input.tactic-toggle");
            if (toggle && toggle.checked) {
              return false;
            }
            hideParentTooltips(inst.reference);
            if (blockedByTippy(inst.reference)) { return false; }

          } else if (inst.reference.querySelector(".hover-info") || "versoHover" in inst.reference.dataset) {
            if (blockedByTactic(inst.reference)) { return false };
            if (blockedByTippy(inst.reference)) { return false; }
          } else { // Nothing to show here!
            return false;
          }
        },
        onShown(inst) { visibleTippyCount++; },
        onHidden(inst) { visibleTippyCount = Math.max(0, visibleTippyCount - 1); },
        content (tgt) {
          const content = document.createElement("span");
          if (tgt.className == 'tactic') {
            const state = tgt.querySelector(".tactic-state").cloneNode(true);
            state.style.display = "block";
            content.appendChild(state);
            content.style.display = "block";
            content.className = "hl lean popup";
          } else {
            content.className = "hl lean";
            content.style.display = "block";
            content.style.maxHeight = "300px";
            content.style.overflowY = "auto";
            content.style.overflowX = "hidden";
            const hoverId = tgt.dataset.versoHover;
            const hoverInfo = tgt.querySelector(".hover-info");
            if (hoverId) { // Docstrings from the table
              // TODO stop doing an implicit conversion from string to number here
              let data = versoDocData[hoverId];
              if (data) {
                const info = document.createElement("span");
                info.className = "hover-info";
                info.style.display = "block";
                info.innerHTML = data;
                content.appendChild(info);
                /* Render docstrings - TODO server-side */
                if ('undefined' !== typeof marked) {
                    for (const d of content.querySelectorAll("code.docstring, pre.docstring")) {
                        const str = d.innerText;
                        const html = marked.parse(str);
                        const rendered = document.createElement("div");
                        rendered.classList.add("docstring");
                        rendered.innerHTML = html;
                        d.parentNode.replaceChild(rendered, d);
                    }
                }
              } else {
                content.innerHTML = "Failed to load doc ID: " + hoverId;
              }
            } else if (hoverInfo) { // The inline info, still used for compiler messages
              content.appendChild(hoverInfo.cloneNode(true));
            }
            const extraLinks = tgt.parentElement.dataset['versoLinks'];
            if (extraLinks) {
              try {
                const extras = JSON.parse(extraLinks);
                const links = document.createElement('ul');
                links.className = 'extra-doc-links';
                extras.forEach((l) => {
                  const li = document.createElement('li');
                  li.innerHTML = "<a href=\"" + l['href'] + "\" title=\"" + l.long + "\">" + l.short + "</a>";
                  links.appendChild(li);
                });
                content.appendChild(links);
              } catch (error) {
                console.error(error);
              }
            }
          }
          return content;
        }
      };


      document.querySelectorAll('.hl.lean .const.token, .hl.lean .keyword.token, .hl.lean .literal.token, .hl.lean .option.token, .hl.lean .var.token, .hl.lean .typed.token, .hl.lean .level-var, .hl.lean .level-const, .hl.lean .level-op, .hl.lean .sort').forEach(element => {
        element.setAttribute('data-tippy-theme', 'lean');
      });
      document.querySelectorAll('.hl.lean .has-info.warning').forEach(element => {
        element.setAttribute('data-tippy-theme', 'warning message');
      });
      document.querySelectorAll('.hl.lean .has-info.information').forEach(element => {
        element.setAttribute('data-tippy-theme', 'info message');
      });
      document.querySelectorAll('.hl.lean .has-info.error').forEach(element => {
        element.setAttribute('data-tippy-theme', 'error message');
      });
      document.querySelectorAll('.hl.lean .tactic').forEach(element => {
        element.setAttribute('data-tippy-theme', 'tactic');
      });
      // Skip tokens inside closed tactics — they interfere with tactic tippys
      const closedTactics = new Set();
      document.querySelectorAll('.hl.lean .tactic').forEach(tactic => {
        const toggle = tactic.querySelector('input.tactic-toggle');
        if (toggle && !toggle.checked) closedTactics.add(tactic);
      });
      function isInsideClosedTactic(el) {
        const tactic = el.closest('.tactic');
        return tactic && tactic !== el && closedTactics.has(tactic);
      }

      const tokenSelector = '.hl.lean .const.token, .hl.lean .keyword.token, .hl.lean .literal.token, .hl.lean .option.token, .hl.lean .var.token, .hl.lean .typed.token, .hl.lean .has-info, .hl.lean .tactic, .hl.lean .level-var, .hl.lean .level-const, .hl.lean .level-op, .hl.lean .sort';
      tippy(Array.from(document.querySelectorAll(tokenSelector)).filter(el => !isInsideClosedTactic(el)), defaultTippyProps);

      // Create/destroy token tippys when tactic checkbox toggles
      const tacticTippySelector = '.const.token, .keyword.token, .literal.token, .option.token, .var.token, .typed.token, .has-info, .level-var, .level-const, .level-op, .sort';
      document.querySelectorAll('.hl.lean .tactic').forEach(tactic => {
        const toggle = tactic.querySelector('input.tactic-toggle');
        if (toggle) toggle.addEventListener('change', () => {
          if (toggle.checked) {
            closedTactics.delete(tactic);
            tactic.querySelectorAll('.token').forEach(tok => {
              if (!tok._tippy && tok.matches(tacticTippySelector)) {
                tippy(tok, defaultTippyProps);
              }
            });
          } else {
            closedTactics.add(tactic);
            tactic.querySelectorAll('.token').forEach(tok => {
              if (tok._tippy) tok._tippy.destroy();
            });
          }
        });
      });
  });
}
