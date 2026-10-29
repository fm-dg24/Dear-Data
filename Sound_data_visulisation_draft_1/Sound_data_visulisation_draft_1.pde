
String[] lines;
SoundData[] sounds;

void setup()
{
  size(1600, 600);

  lines = loadStrings("Sound data collection.csv");
  sounds = new SoundData[lines.length - 1];

  for (int i = 1; i < lines.length; i = i + 1)
  {
    String[] values = split(lines[i], ",");
    sounds[i - 1] = new SoundData(values);
  }
}

void draw()
{
  background(255);
  stroke(30);
  strokeWeight(9);

  for (int i = 0; i < sounds.length; i = i + 1)
  {
    float x = map(i, 0, sounds.length, 30, width - 30);
    float barHeight = map(sounds[i].loudness, 1, 10, 12, height / 2 - 30);

    line(x, height / 2 - barHeight,
         x, height / 2 + barHeight);
  }
}

class SoundData
{
  float loudness;
  String location;
  String type;

  SoundData(String[] values)
  {
    location = values[2];
    loudness = float(values[3]);
    type = trim(values[4]);
  }
}
