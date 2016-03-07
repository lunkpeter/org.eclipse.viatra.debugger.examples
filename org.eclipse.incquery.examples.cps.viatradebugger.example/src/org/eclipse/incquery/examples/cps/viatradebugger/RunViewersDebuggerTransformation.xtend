package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.debug.breakpoints.impl.TransformationBreakpoint
import org.eclipse.viatra.transformation.debug.configuration.TransformationDebuggerConfiguration
import org.eclipse.viatra.transformation.debug.ui.impl.ViewersDebugger
import org.junit.Test
import org.eclipse.incquery.examples.cps.viatradebugger.example.CPSModelInitializer
import org.eclipse.incquery.examples.cps.viatradebugger.patterns.ViewersPatterns

class RunViewersDebuggerTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation
	
	@Test def void runViatraViewersTransformation() {
		val init = new CPSModelInitializer()
		val cps2dep = init.loadModel("output/example.cyberphysicalsystem")
		
		
		transformation = new ViatraTransformation(cps2dep)
		ViewersPatterns.instance.prepare(engine)
		val configuration = new TransformationDebuggerConfiguration(
				new ViewersDebugger(engine, ViewersPatterns.instance.specifications),
                new TransformationBreakpoint(ruleProvider.hostRule.ruleSpecification)
        );
		
		val executor = createAdaptableExecutor()
			.setQueryEngine(engine)
			.addConfiguration(configuration).build() as AdaptableExecutor
			
		transformation.setExecutor(executor).initialize()
		transformation.execute
	}
}
