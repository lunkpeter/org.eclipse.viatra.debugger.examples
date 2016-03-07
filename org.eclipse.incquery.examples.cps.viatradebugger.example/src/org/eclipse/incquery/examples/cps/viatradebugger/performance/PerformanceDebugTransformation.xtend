package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.PerformanceTestDebuggerUI
import org.eclipse.incquery.runtime.evm.api.ExecutionSchema
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.emf.runtime.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.emf.runtime.debug.breakpoints.impl.TransformationBreakpoint
import org.eclipse.viatra.emf.runtime.debug.configuration.TransformationDebuggerConfiguration
import org.eclipse.viatra.emf.runtime.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceDebugTransformation extends BasePerformanceTransformation{
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override ExecutionSchema createExecutionSchema(){
		val debugAdapterConfiguration = new TransformationDebuggerConfiguration(
                new PerformanceTestDebuggerUI(),
                new TransformationBreakpoint(ruleProvider.hostRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.applicationRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.stateMachineRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.stateRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.transitionRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.triggerRule.ruleSpecification)	
        );
		
		val executor = createAdaptableExecutor()
			.setIncQueryEngine(engine)
			.addConfiguration(debugAdapterConfiguration).build() as AdaptableExecutor
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
}