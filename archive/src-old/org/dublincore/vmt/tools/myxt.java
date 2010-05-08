//
// Simple XSLT Processor
// $Id: myxt.java,v 1.1.1.1 2003/10/13 19:43:58 wagnerh Exp $
//
// note: J2SDK1.4 (or higher) is required to compile this program.
//

//package org.dublincore.vmt.tools;

import java.io.File;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.Source;
import javax.xml.transform.Result;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;

public class myxt
{
    public static void main(String[] args) {
	int nArgs = 0;
	TransformerFactory factory = null;
	Transformer transformer = null;

	if (args.length < 2) {
	    usage();
	}
	try {
	    factory = TransformerFactory.newInstance();
	    transformer = factory.newTransformer(new StreamSource(args[1]));
	} catch (TransformerConfigurationException e) {
	    System.err.println(e.getMessageAndLocation());
	    System.exit(-1);
	}

	for (int i=0; i<args.length; i++) {
	    int k = args[i].indexOf('=');
	    if (k > 0) {
		String key = args[i].substring(0, k);
		String value = args[i].substring(k + 1);
		transformer.setParameter(key, value); 
	    } else {
		args[nArgs++] = args[i];
	    }
	}
	if (nArgs != 2 && nArgs != 3) {
	    usage();
	}

	Source inputSource = new StreamSource(args[0]);
	
	Result outputResult = null;
	if (nArgs == 3) {
	    outputResult = new StreamResult(args[2]);
	} else {
	    outputResult = new StreamResult(System.out);
	}

	try {
	    transformer.transform(inputSource,outputResult);
	} catch (TransformerException e) {
	    System.err.println(e.getMessageAndLocation());
	    System.exit(-1);
	}
    }

    public static void usage() {
	System.err.println("usage: myxt source stylesheet [result] [param=value]...");
	System.exit(-1);
    }
}
