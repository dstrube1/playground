// This script and many more are available free online at -->
// The JavaScript Source!! http://javascript.internet.com -->

// Begin
function shake(n) {
if (parent.moveBy) {
for (i = 10; i > 0; i--) {
for (j = n; j > 0; j--) {
parent.moveBy(0,i);
parent.moveBy(i,0);
parent.moveBy(0,-i);
parent.moveBy(-i,0);
         }
      }
   }
}
// End -->
// call like so:
// <a href="javascript:shake(10)" > test</a> 
//	<!-- instead of 
// <center><form> 
// <input type=button onClick="shake(2)" value="Shake Screen">
// </form> </center>
// hahahahahaha!
