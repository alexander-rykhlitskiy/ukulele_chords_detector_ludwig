# Ukulele Chords Detector Ludwig edition
Based on https://uber.github.io/ludwig/examples/#spoken-digit-speech-recognition

For docs see https://uber.github.io/ludwig/user_guide/#audio-features

For the origins of the project and sounds data see https://github.com/alexander-rykhlitskiy/ukulele_chords_detector

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

### Conclusion
Examples from docs with prepared datasets run pretty smoothly, though you still need to read more, e.g. to find out you need ludwig[audio] package to be installed.

But when you prepare your own data, most likely you will face tricky obscure erros like `ValueError: could not broadcast input array from shape (2400,2) into shape (2400)`. This error means you need wav file with 1 channel instead of 2. It can be easily achieved with `sox {} {}.wav remix 1`, but still it creates some difficulties with getting started.

Maybe in version 1.0 they will improve docs and error messages, and then it will be more convenient. But for now I would prefer to write python script based on pure TensorFlow.
