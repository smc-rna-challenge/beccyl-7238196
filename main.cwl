class: Workflow
cwlVersion: v1.0
doc: jaffa workflow
hints: []
id: main
inputs:
- {id: TUMOR_FASTQ_1, type: File}
- {id: TUMOR_FASTQ_2, type: File}
- {id: genome, type: File}
- {id: jaffa_reference, type: File}
name: main
outputs:
- {id: OUTPUT, outputSource: converttobedpe/fusionout, type: File}
steps:
- id: converttobedpe
  in:
  - {id: input, source: jaffa/jaffa_fusions_list}
  - {default: output.bedpe, id: output}
  out: [fusionout]
  run: converter.cwl
- id: jaffa
  in:
  - {id: fastq1, source: TUMOR_FASTQ_1}
  - {id: fastq2, source: TUMOR_FASTQ_2}
  - {default: '%_*.fq.gz', id: fastqInputFormat}
  - {id: genomeFasta, source: twoBitToFa/output}
  - {default: /opt/JAFFA/JAFFA_direct.groovy, id: pipeline}
  - {id: refBase, source: tar/output}
  - {default: 1, id: threads}
  out: [jaffa_fusions_list]
  run: jaffa.cwl
- id: tar
  in:
  - {id: input, source: jaffa_reference}
  out: [output]
  run: tar.cwl
- id: twoBitToFa
  in:
  - {id: input, source: genome}
  - {default: hg19.fa, id: output}
  out: [output]
  run: twoBitToFa.cwl
