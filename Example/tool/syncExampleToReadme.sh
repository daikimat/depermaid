#!/bin/sh
srcRoot=$1
replacement=$(xcrun --sdk macosx swift package --package-path $srcRoot/Package depermaid)
echo $replacement
perl -i -0777 -pe "s/(Usage.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $srcRoot/../README.md

replacement=$(xcrun --sdk macosx swift package --package-path $srcRoot/Package depermaid --test)
echo $replacement
perl -i -0777 -pe "s/(Including Test Targets.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $srcRoot/../README.md

replacement=$(xcrun --sdk macosx swift package --package-path $srcRoot/Package depermaid --executable)
echo $replacement
perl -i -0777 -pe "s/(Including Executable Targets.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $srcRoot/../README.md

replacement=$(xcrun --sdk macosx swift package --package-path $srcRoot/Package depermaid --product)
echo $replacement
perl -i -0777 -pe "s/(Including Products.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $srcRoot/../README.md

replacement=$(xcrun --sdk macosx swift package --package-path $srcRoot/Package depermaid --test --executable --product)
echo $replacement
perl -i -0777 -pe "s/(Including All.*?)(\`\`\`mermaid.*?\`\`\`)/\$1$replacement/s" $srcRoot/../README.md