import Lake
open System Lake DSL

require «verso-slides» from git
  "https://github.com/leanprover/verso-slides.git"@"main"

package eindhoven26 where
  version := v!"0.1.0"

lean_lib Slides

@[default_target] lean_exe eindhoven26 where root := `Main
