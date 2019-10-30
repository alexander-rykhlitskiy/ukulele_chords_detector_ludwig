https://uber.github.io/ludwig/getting_started/
https://uber.github.io/ludwig/examples/

```bash
docker build -t test_ludwig .
docker run -v $(pwd):/app -it --rm test_ludwig ludwig experiment --data_csv train.csv --model_definition_file model_definition.yaml
ludwig experiment --data_csv train.csv --model_definition_file model_definition.yaml
```

Ukulele notes detection
```bash
ludwig experiment --data_csv train_notes.csv --model_definition_file notes_model_definition_file.yaml
