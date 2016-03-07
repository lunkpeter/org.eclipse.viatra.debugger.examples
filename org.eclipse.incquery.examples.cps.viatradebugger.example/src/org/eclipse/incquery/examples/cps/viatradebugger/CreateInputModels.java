package org.eclipse.incquery.examples.cps.viatradebugger;

import org.eclipse.incquery.examples.cps.viatradebugger.example.CPSModelInitializer;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

@RunWith(Parameterized.class)
public class CreateInputModels {
    
	@Parameters
	
	
	
	
	
	@Test
    @Ignore
    public void runDebugger() {
        CPSModelInitializer init = new CPSModelInitializer();
        
        init.createModel(64, "output/output");
        
    }
}
