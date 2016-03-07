package org.eclipse.incquery.examples.cps.viatradebugger.performance.util;

import java.util.Set;

import org.eclipse.incquery.runtime.evm.api.Activation;
import org.eclipse.viatra.emf.runtime.debug.TransformationDebugger.DebuggerActions;
import org.eclipse.viatra.emf.runtime.debug.controller.IDebugController;

public class PerformanceTestDebuggerUI implements IDebugController {

    @Override
    public void displayTransformationContext(Activation<?> act) {}

    @Override
    public void displayConflictingActivations(Set<Activation<?>> activations) {}

    @Override
    public DebuggerActions getDebuggerAction() {
        return DebuggerActions.Continue;
    }

    @Override
    public Activation<?> getSelectedActivation() {
        return null;
    }

}
