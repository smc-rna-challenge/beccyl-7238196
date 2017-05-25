baseCommand: [twoBitToFa]
class: CommandLineTool
cwlVersion: v1.0
doc: Convert jaffa fusion output to bedpe format
hints:
- {class: DockerRequirement, dockerPull: 'quay.io/smc-rna-challenge/beccyl-7238196-jaffa:1.0.0'}
inputs:
- id: input
  inputBinding: {position: 1}
  type: File
- id: output
  inputBinding: {position: 2}
  type: string
outputs:
- id: output
  outputBinding: {glob: $(inputs.output)}
  type: File
requirements:
- {class: InlineJavascriptRequirement}
