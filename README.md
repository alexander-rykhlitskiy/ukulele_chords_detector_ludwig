https://uber.github.io/ludwig/getting_started/
https://uber.github.io/ludwig/examples/

```bash
docker build -t test_ludwig .
docker run -v $(pwd):/app -it --rm test_ludwig /bin/bash
```

Ukulele notes detection
```bash
find . -type f -name '*.wav' -exec sox {} {}.wav remix 1 \;
rm train_notes.hdf5 train_notes.json # strange, but it increases accuracy
ludwig train --data_csv train_notes.csv --model_definition_file notes_model_definition.yaml
ludwig predict --data_csv test_notes.csv -m results/experiment_run_/model
```
