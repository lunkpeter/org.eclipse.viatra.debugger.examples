package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.incquery.examples.cps.viatradebugger.example.InitializerComponent
import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.emf.runtime.debug.breakpoints.impl.TransformationBreakpoint
import org.eclipse.viatra.emf.runtime.debug.configuration.TransformationDebuggerConfiguration
import org.junit.Test
import org.eclipse.viatra.emf.runtime.debug.ui.impl.ViewersDebugger

class RunViewersDebuggerTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation
	
	@Test def void runViatraViewersTransformation() {
		val init = new InitializerComponent()
		val cps2dep = init.loadModel("output/example.cyberphysicalsystem")
		
		transformation = new ViatraTransformation(cps2dep)
		
		val configuration = new TransformationDebuggerConfiguration(
				new ViewersDebugger(engine, queries.specifications),
                new TransformationBreakpoint(ruleProvider.hostRule.ruleSpecification)
        );
		
		val executor = createAdaptableExecutor()
			.setIncQueryEngine(engine)
			.addConfiguration(configuration).build() as AdaptableExecutor
			
		transformation.setExecutor(executor).initialize()
		transformation.execute
	}
}
