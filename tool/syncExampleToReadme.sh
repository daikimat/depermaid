#!/bin/sh
root=$(dirname $0)/..
replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid)
echo $replacement
perl -i -0777 -pe "s/(\# Usage.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --test)
echo $replacement
perl -i -0777 -pe "s/(\# Including Test Targets.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --executable)
echo $replacement
perl -i -0777 -pe "s/(\# Including Executable Targets.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --product)
echo $replacement
perl -i -0777 -pe "s/(\# Including Products.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(\# Including All.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --direction TD --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(\# Direction.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/ComplexPackages depermaid LR)
echo $replacement
perl -i -0777 -pe "s/(\# Minimal Dependencies.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md

replacement=$(swift package --package-path $root/Example/ComplexPackages depermaid --minimal)
echo $replacement
perl -i -0777 -pe "s/(\# Minimal Dependencies.*?\`\`\`mermaid.*?\`\`\`.*?\`\`\`mermaid\n)(.*?)(\`\`\`)/\$1$replacement\n\$3/s" $root/README.md
