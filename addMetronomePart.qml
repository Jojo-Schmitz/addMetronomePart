import QtQuick 2.0
import MuseScore 3.0

MuseScore {
   menuPath: "Plugins.Add Metronome Part"
   description: "Add metronome part"
   version: "0.4"
   requiresScore: true
   id: addMetronomePart
   //4.4 title: "Add Metronome Part"

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
          addMetronomePart.title = "Add Metronome Part";
      }
   }

   onRun: {
      curScore.startCmd()
      curScore.appendPart("wood-blocks")
      var idx = curScore.nstaves-1
      
      curScore.parts[idx].isMetro = true
      
      var c = curScore.newCursor()
      c.rewind(0)
      c.staffIdx = idx
      c.voice = 0
      if( c.measure.timesigActual.str != c.measure.timesigNominal.str )
         c.nextMeasure()
      do{
         var ts = c.measure.timesigActual
         c.setDuration( 1, ts.denominator )
         for( var i=1; i <= ts.numerator; i++ )
            c.addNote( i==1 ? 76 : 77, false )
      }while( c.prev() && c.nextMeasure() )
      curScore.endCmd()
      
      return
   }
}

