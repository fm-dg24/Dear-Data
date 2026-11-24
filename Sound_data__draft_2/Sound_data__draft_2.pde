
String[] lines;
SoundData[] sounds;
int colourMode = 0;

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
  strokeWeight(9);

  float spacing = (width - 60.0) / sounds.length;
  float movement = (millis() / 30.0) % spacing;

  for (int i = 0; i < sounds.length; i = i + 1)
  {
    float x = 30 + i * spacing - movement;

    if (x < 30)
    {
      x = x + width - 60;
    }

    float barHeight = map(sounds[i].loudness, 1, 10, 12, height / 2 - 30);

    if (colourMode == 0)
    {
      if (sounds[i].type.equals("Vehicle"))
        stroke(220, 70, 70);
      else if (sounds[i].type.equals("Nature"))
        stroke(60, 160, 90);
      else if (sounds[i].type.equals("Household"))
        stroke(70, 120, 220);
      else
        stroke(180, 100, 190);
    }
    else
    {
      int locationNumber = i;

      for (int j = 0; j < i; j = j + 1)
      {
        if (sounds[i].location.equals(sounds[j].location))
        {
          locationNumber = j;
          break;
        }
      }

      if (locationNumber % 4 == 0)
        stroke(220, 100, 70);
      else if (locationNumber % 4 == 1)
        stroke(70, 150, 200);
      else if (locationNumber % 4 == 2)
        stroke(100, 170, 100);
      else
        stroke(170, 100, 190);
    }

    line(x, height / 2 - barHeight,
         x, height / 2 + barHeight);
  }
}

void keyPressed()
{
  if (key == 't' || key == 'T')
    colourMode = 0;

  if (key == 'l' || key == 'L')
    colourMode = 1;
}

class SoundData
{
  float loudness;
  String location;
  String type;

  SoundData(String[] values)
  {
    location = trim(values[2]);
    loudness = float(values[3]);
    type = trim(values[4]);
  }
}
