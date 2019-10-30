# Ukulele Chords Detector Ludwig edition
Based on https://uber.github.io/ludwig/examples/#spoken-digit-speech-recognition

For more info and sounds data see https://github.com/alexander-rykhlitskiy/ukulele_chords_detector

```bash
docker build -t test_ludwig .
docker run -v $(pwd):/app -it --rm test_ludwig /bin/bash
```

### Running

Prepare csv files
```bash
git submodule update --init --recursive
find . -type f -name '*.wav' -exec sox {} {}_1_channel.wav remix 1 \;
find . -type f -name '*_1_channel.wav' | grep "/train/" | (echo "audio_path,label"; ruby -e 'puts STDIN.read.split("\n").map { |l| "#{l},#{l.match(/samples\/([^\/]+)\//)[1]}" }.join("\n")') > train_notes.csv
(echo "audio_path"; find . -type f -name '*_1_channel.wav' | grep "/test/") > test_notes.csv
```

Run training and prediction
```bash
rm train_notes.hdf5 train_notes.json # strange, but sometimes it increases accuracy
ludwig train --data_csv train_notes.csv --model_definition_file notes_model_definition.yaml
ludwig predict --data_csv test_notes.csv -m results/experiment_run_/model
```

### Results comparing to pure TensorFlow implementation
```diff
+ Ludwig automatically calculates number of epochs (seems to be pretty accurate)
+ Allows to configure many nifty sound processing parameters in model yaml file
- Accuracy seems to be lower
- Less control, trickier errors (surprise!)
```
