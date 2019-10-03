importPackage(Packages.org.csstudio.opibuilder.scriptUtil);

var min = display.getWidget("minimumLabel").getPropertyValue("text");
var max = display.getWidget("maximumLabel").getPropertyValue("text");

display.getWidget("minimumInput").setPropertyValue("text", min);
display.getWidget("maximumInput").setPropertyValue("text", max);
