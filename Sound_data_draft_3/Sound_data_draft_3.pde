
String[] lines;
SoundData[] sounds;
int colourMode = 0;

void setup()
{
  size(1600, 600);
  colorMode(HSB, 255);

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

  // Draw the legend
  fill(0);
  textSize(16);

  if (colourMode == 0)
    text("SOUND TYPE (Press L for Location)", 30, 25);
  else
    text("LOCATION (Press T for Type)", 30, 25);

  float legendX = 30;
  float legendY = 55;

  for (int i = 0; i < sounds.length; i = i + 1)
  {
    if (isFirstCategory(i))
    {
      fill(getColour(getCategoryIndex(i)));
      noStroke();
      rect(legendX, legendY - 12, 14, 14);

      fill(0);
      text(getCategory(i), legendX + 22, legendY);

      legendX = legendX + textWidth(getCategory(i)) + 55;

      if (legendX > width - 150)
      {
        legendX = 30;
        legendY = legendY + 25;
      }
    }
  }

  // Draw the moving waveform
  strokeWeight(9);

  float spacing = (width - 60.0) / sounds.length;
  float movement = (millis() / 30.0) % spacing;

  for (int i = 0; i < sounds.length; i = i + 1)
  {
    float x = 30 + i * spacing + movement;

    if (x > width - 30)
      x = x - width + 60;

    float barHeight = map(sounds[i].loudness, 1, 10, 12, 210);

    stroke(getColour(getCategoryIndex(i)));

    line(x, 360 - barHeight, x, 360 + barHeight);
  }
}

String getCategory(int i)
{
  if (colourMode == 0)
    return sounds[i].type;
  else
    return sounds[i].location;
}

boolean isFirstCategory(int i)
{
  for (int j = 0; j < i; j = j + 1)
  {
    if (getCategory(i).equals(getCategory(j)))
      return false;
  }

  return true;
}

int getCategoryIndex(int i)
{
  int index = 0;

  for (int j = 0; j < i; j = j + 1)
  {
    if (isFirstCategory(j))
      index = index + 1;

    if (getCategory(i).equals(getCategory(j)))
      return getCategoryIndex(j);
  }

  return index;
}

color getColour(int index)
{
  return color((index * 67) % 255, 180, 220);
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
