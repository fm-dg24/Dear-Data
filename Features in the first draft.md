### Features I have included in the first draft:

- CSV data loading: my sound dataset from a CSV file loads using loadStrings().



- Skipping the header: I start my CSV loop at index 1 so I do not treat the column headings as an observation.



- Processing my data: I use split() to separate each row into individual values.



- A class and objects: I have created a SoundData class and use an object for each sound observation.



- Storing sound information: Each object stores the sound's loudness, location and type.



- A continuous-looking wave: I use line() to connect consecutive points across the screen.



- Loudness affecting the wave: I use map() to convert loudness scores from 1–10 into different amplitudes.



- Alternating points: I use an if statement and the remainder operator % to alternate points above and below the centre.



- A basic visual design: I have set a white background, dark grey lines and a line thickness of 2 pixels.



- Processing and Java concepts: My code uses variables, arrays, loops, a class, a constructor, objects, a method that returns a value, and conditional logic.



### Features I have not included in the first draft:

- Colour modes: Currently no option to switch the colours of my wave by sound type and location yet. All the lines currently use the same colour.



- Animation: My wave does not move across the screen or loop from left to right and back again.





