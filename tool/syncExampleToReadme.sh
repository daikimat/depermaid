#!/bin/sh
root=$1
replacement=$(xcrun --sdk macosx swift package --package-path $root/Example/Package depermaid)
echo $replacement
perl -i -0777 -pe "s/(\# Usage.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(xcrun --sdk macosx swift package --package-path $root/Example/Package depermaid --test)
echo $replacement
perl -i -0777 -pe "s/(\# Including Test Targets.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(xcrun --sdk macosx swift package --package-path $root/Example/Package depermaid --executable)
echo $replacement
perl -i -0777 -pe "s/(\# Including Executable Targets.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(xcrun --sdk macosx swift package --package-path $root/Example/Package depermaid --product)
echo $replacement
perl -i -0777 -pe "s/(\# Including Products.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(xcrun --sdk macosx swift package --package-path $root/Example/Package depermaid --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(\# Including All.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md

replacement=$(xcrun --sdk macosx swift package --package-path $root/Example/Package depermaid --direction LR --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(\# Direction.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $root/README.md