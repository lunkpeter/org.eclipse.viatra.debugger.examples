package org.eclipse.incquery.examples.cps.viatradebugger

import org.eclipse.incquery.examples.cps.viatradebugger.example.InitializerComponent
import org.eclipse.incquery.examples.cps.viatradebugger.example.ViatraTransformation
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.emf.runtime.debug.breakpoints.impl.ConditionalTransformationBreakpoint
import org.eclipse.viatra.emf.runtime.debug.configuration.TransformationDebuggerConfiguration
import org.junit.Test

class RunCondDebuggerTransformation {
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	extension ViatraTransformation transformation

	@Test def void runViatraConditionalDebugTransformation() {
		val init = new InitializerComponent()
		val cps2dep = init.loadModel("output/example.cyberphysicalsystem")
		
		transformation = new ViatraTransformation(cps2dep)
		
		val debugAdapterConfiguration = new TransformationDebuggerConfiguration(
			new ConditionalTransformationBreakpoint(engine, queries.getApplicationInstance(engine).specification, 2))
			
		val executor = createAdaptableExecutor().setIncQueryEngine(engine).addConfiguration(
			debugAdapterConfiguration).build()
			
		transformation.setExecutor(executor).initialize()
		transformation.execute
		
	}

}
