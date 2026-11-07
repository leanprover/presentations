import Lake
open System Lake DSL

require «verso-slides» from git
  "https://github.com/leanprover/verso-slides.git"@"main"

package lambdaworld26 where
  version := v!"0.1.0"

-- Build the HTML with the interpreter instead of a compiled executable
-- (as in leanprover/verso#1054), which is faster after edits:
--   lake lean Main.lean -- --run Main.lean
@[default_target] lean_lib Slides
