#!/bin/sh
root=$(dirname $0)/..
replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid)
echo $replacement
perl -i -0777 -pe "s/(\# Usage.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --test)
echo $replacement
perl -i -0777 -pe "s/(\# Including Test Targets.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --executable)
echo $replacement
perl -i -0777 -pe "s/(\# Including Executable Targets.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --product)
echo $replacement
perl -i -0777 -pe "s/(\# Including Products.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(\# Including All.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/AnimalPackages depermaid --direction TD --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(\# Direction.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/ComplexPackages depermaid LR)
echo $replacement
perl -i -0777 -pe "s/(\# Minimal Dependencies.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(swift package --package-path $root/Example/ComplexPackages depermaid --minimal)
echo $replacement
perl -i -0777 -pe "s/(\# Minimal Dependencies.*?\`\`\`mermaid.*?\`\`\`.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md
