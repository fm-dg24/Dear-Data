String[] lines;
SoundData[] sounds;
int colourMode = 0;

void setup()
{
  size(1600, 600);
  lines = loadStrings("Sound data collection.csv");
  sounds = new SoundData[lines.length - 1];

  for (int i = 1; i < lines.length; i++)
  {
    sounds[i - 1] = new SoundData(split(lines[i], ","));
  }
}

void draw()
{
  background(12);
  drawLegend();

  float spacing = (width - 60.0) / sounds.length;
  float movement = (millis() % 20000) / 20000.0 * (width - 60);

  drawRibbon(movement, spacing);
  drawRibbon(movement - (width - 60), spacing);
}

void drawRibbon(float movement, float spacing)
{
  float cy = 370;

  noFill();
  stroke(100);
  strokeWeight(2);

  for (int side = -1; side <= 1; side += 2)
  {
    beginShape();

    for (int i = -2; i < sounds.length + 2; i++)
    {
      int index = (i + sounds.length) % sounds.length;
      float x = 30 + i * spacing + movement;
      float h = map(sounds[index].loudness, 1, 10, 15, 145);

      curveVertex(x, cy + side * h);
    }

    endShape();
  }

  for (int i = 0; i < sounds.length; i++)
  {
    float x = 30 + i * spacing + movement;
    float h = map(sounds[i].loudness, 1, 10, 15, 145);

    stroke(getColour(i));
    strokeWeight(7);
    line(x, cy - h, x, cy + h);
  }
}

void drawLegend()
{
  fill(255);
  textSize(16);
  text(colourMode == 0 ? "TYPE  |  Press L for Location" :
                         "LOCATION  |  Press T for Type", 30, 25);

  if (colourMode == 0)
  {
    drawKey("Nature", color(140, 255, 112), 30, 55);
    drawKey("Household", color(255, 87, 34), 220, 55);
    drawKey("Vehicle", color(52, 120, 232), 430, 55);
    drawKey("Human", color(255, 20, 147), 30, 85);
    drawKey("Device", color(0, 229, 255), 220, 85);
    drawKey("Object", color(214, 255, 0), 430, 85);
  }
  else
  {
    drawKey("Indoor", color(255, 48, 48), 30, 55);
    drawKey("Outdoor", color(40, 120, 255), 220, 55);
  }
}

void drawKey(String name, color c, float x, float y)
{
  fill(c);
  noStroke();
  rect(x, y - 12, 14, 14);
  fill(255);
  text(name, x + 22, y);
}

color getColour(int i)
{
  if (colourMode == 1)
  {
    if (sounds[i].location.equalsIgnoreCase("Indoor"))
      return color(255, 48, 48);
    return color(40, 120, 255);
  }

  if (sounds[i].type.equalsIgnoreCase("Nature"))
    return color(140, 255, 112);
  if (sounds[i].type.equalsIgnoreCase("Household"))
    return color(255, 87, 34);
  if (sounds[i].type.equalsIgnoreCase("Vehicle"))
    return color(52, 120, 232);
  if (sounds[i].type.equalsIgnoreCase("Human"))
    return color(255, 20, 147);
  if (sounds[i].type.equalsIgnoreCase("Device"))
    return color(0, 229, 255);

  return color(214, 255, 0);
}

void keyPressed()
{
  if (key == 't' || key == 'T') colourMode = 0;
  if (key == 'l' || key == 'L') colourMode = 1;
}

class SoundData
{
  float loudness;
  String location, type;

  SoundData(String[] values)
  {
    location = trim(values[2]);
    loudness = float(values[3]);
    type = trim(values[4]);
  }
}
