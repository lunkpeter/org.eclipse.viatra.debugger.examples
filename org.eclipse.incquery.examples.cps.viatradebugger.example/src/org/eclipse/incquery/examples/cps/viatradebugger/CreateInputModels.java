package org.eclipse.incquery.examples.cps.viatradebugger;

import org.eclipse.incquery.examples.cps.viatradebugger.example.CPSModelInitializer;
import org.junit.Ignore;
import org.junit.Test;

public class CreateInputModels {
	@Test
    @Ignore
    public void runDebugger() {
        CPSModelInitializer init = new CPSModelInitializer();
        
        init.createModel(64, "output/output");
        
    }
}
