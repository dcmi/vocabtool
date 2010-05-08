//package org.dublincore.vmt.tools;

import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerConfigurationException;

import java.io.FileOutputStream;
import java.io.FileNotFoundException;

import java.io.*;
import java.net.*;
import java.util.*;

/**
 *  Use the TraX interface to perform a transformation in the simplest manner possible
 */


public class usage {
	private static String[] monthNames = {"January","February","March","April","May","June","July","August","September","October","November","December"};

	public static void main(String[] args)
		throws TransformerException, TransformerConfigurationException, 
		FileNotFoundException, IOException  { 

		String proFile = null;
		String xmlFile = null;
		String xslFile = null;
		String outFile = null;
		String ns = null;
		String tt = null;
		String hfn = null;
		Calendar tDate;
		String todaysDate = null;
		
 
		if (args.length == 1) {
			proFile = args[0];
			System.out.println("using property file: " + proFile);
		} else {
			System.out.println("improper usage");
			usage();
			System.exit(-1);
		}
		
		try {
			Properties p = new Properties();
			InputStream pin = new FileInputStream(proFile);
			p.load(pin);
	
			xmlFile = p.getProperty("xmlFile");
			xslFile = p.getProperty("xslFile");
			outFile = p.getProperty("outFile");
			ns = p.getProperty("ns");
			tt = p.getProperty("tt");
			hfn = p.getProperty("hfn");
			
			tDate = new GregorianCalendar();
			StringBuffer ts = new StringBuffer();
			ts.append(Integer.toString(tDate.get(Calendar.YEAR)));
			if (tDate.get(Calendar.MONTH) > 8) {
				ts.append("-" + Integer.toString(tDate.get(Calendar.MONTH) + 1));
			} else {
				ts.append("-0" + Integer.toString(tDate.get(Calendar.MONTH) + 1));
			}
			if (tDate.get(Calendar.DATE) > 9) {
				ts.append("-" + Integer.toString(tDate.get(Calendar.DATE)));
			} else {
				ts.append("-0" + Integer.toString(tDate.get(Calendar.DATE)));
			}
			todaysDate = ts.toString();
		
		} catch (Exception e) {
			System.out.println("error reading properties file");
	   	System.err.println(e);
			e.printStackTrace();
		}

		TransformerFactory tFactory = TransformerFactory.newInstance();
		Transformer transformer = tFactory.newTransformer(new StreamSource(xslFile));
		transformer.setOutputProperty(OutputKeys.ENCODING, "UTF8");
		transformer.setParameter("todaysDate", todaysDate);
		if (ns != null)
			transformer.setParameter("ns", ns);
		if (tt != null)
			transformer.setParameter("tt", tt);
		transformer.setParameter("hfn", hfn);
 		transformer.transform(new StreamSource(xmlFile), 
			new StreamResult(new FileOutputStream(outFile)));

		System.out.println("done!  results are in: " + outFile);
	}

	private static final void usage() {
		System.out.println("Usage: usage <property file name>");
	}

}