package org.eclipse.incquery.examples.cps.viatradebugger;

import org.eclipse.incquery.examples.cps.viatradebugger.example.InitializerComponent;
import org.junit.Ignore;
import org.junit.Test;

public class CreateInputModels {
    @Test
    @Ignore
    public void runDebugger() {
        InitializerComponent init = new InitializerComponent();
        
        init.createModel(64, "output/output");
        
    }
}
