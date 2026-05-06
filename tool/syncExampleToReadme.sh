#!/bin/sh
root=$(dirname $0)/..

# Replace the interior of a ```mermaid ... ``` fenced block that follows a
# given Markdown heading. The replacement is passed via the environment
# (R) and the regex prefix via P, so neither is interpolated into the
# Perl source — making this safe against $, @, \, / in plugin output.
sync_block() {
    prefix=$1
    R=$2 P=$prefix perl -i -0777 -pe '
        my $p = quotemeta($ENV{P});
        s/(${p}.*?```mermaid\n)(.*?)(```)/$1$ENV{R}\n$3/s
    ' $root/README.md
}

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid)
echo $replacement
sync_block "# Usage" "$replacement"

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --test)
echo $replacement
sync_block "# Including Test Targets" "$replacement"

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --executable)
echo $replacement
sync_block "# Including Executable Targets" "$replacement"

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --product)
echo $replacement
sync_block "# Including Products" "$replacement"

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --macro)
echo $replacement
sync_block "# Including Macro Targets" "$replacement"

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --test --executable --product --macro)
echo $replacement
sync_block "# Including All" "$replacement"

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --direction TD --test --executable --product --macro)
echo $replacement
sync_block "# Direction" "$replacement"

replacement=$(swift package --package-path $root/Example/ComplexPackages depermaid LR)
echo $replacement
sync_block "# Minimal Dependencies" "$replacement"

# The "--minimal" example is the *second* fenced block under "# Minimal
# Dependencies", so we have to skip past the first one.
replacement=$(swift package --package-path $root/Example/ComplexPackages depermaid --minimal)
echo $replacement
R=$replacement perl -i -0777 -pe '
    s/(\# Minimal Dependencies.*?```mermaid.*?```.*?```mermaid\n)(.*?)(```)/$1$ENV{R}\n$3/s
' $root/README.md
