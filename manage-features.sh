#!/bin/bash

# Feature Management Script
# Helps manage and track feature implementation progress

set -e

FEATURES_DIR="features"

show_help() {
    echo "📋 Apex Physical Therapy Feature Management"
    echo "==========================================="
    echo "Usage: $0 [command] [feature]"
    echo ""
    echo "Commands:"
    echo "  list       - List all available features"
    echo "  status     - Show implementation status"
    echo "  start      - Run startup script for a feature"
    echo "  finalize   - Run finalization script for a feature"
    echo "  info       - Show details about a feature"
    echo "  help       - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 info testimonials"
    echo "  $0 start blog"
    echo "  $0 finalize testimonials"
    echo ""
    echo "Features are stored in: $FEATURES_DIR/"
}

list_features() {
    echo "📁 Available Features:"
    echo "======================"

    for feature_dir in "$FEATURES_DIR"/*/; do
        if [ -d "$feature_dir" ]; then
            feature_name=$(basename "$feature_dir")
            echo ""
            echo "🔹 $feature_name"
            echo "   Path: $feature_dir"

            # Check for completion marker
            if [ -f ".${feature_name}-complete" ]; then
                echo "   Status: ✅ COMPLETE"
            elif [ -f "$feature_dir/startup.sh" ]; then
                echo "   Status: 🚀 READY"
            else
                echo "   Status: ⚠️  INCOMPLETE"
            fi

            # Show first line of context for description
            if [ -f "$feature_dir/context.md" ]; then
                description=$(head -1 "$feature_dir/context.md" | sed 's/# //')
                echo "   Description: $description"
            fi
        fi
    done

    echo ""
    echo "Total features: $(ls -d "$FEATURES_DIR"/*/ 2>/dev/null | wc -l)"
}

show_status() {
    echo "📊 Feature Implementation Status"
    echo "================================"
    echo ""

    complete_count=0
    ready_count=0
    total_count=0

    for feature_dir in "$FEATURES_DIR"/*/; do
        if [ -d "$feature_dir" ]; then
            feature_name=$(basename "$feature_dir")
            total_count=$((total_count + 1))

            if [ -f ".${feature_name}-complete" ]; then
                echo "✅ $feature_name - COMPLETE"
                complete_count=$((complete_count + 1))
            elif [ -f "$feature_dir/startup.sh" ]; then
                echo "🚀 $feature_name - READY TO START"
                ready_count=$((ready_count + 1))
            else
                echo "⚠️  $feature_name - INCOMPLETE"
            fi
        fi
    done

    echo ""
    echo "Progress: $complete_count/$total_count complete"
    echo "Ready to start: $ready_count features"

    if [ $complete_count -eq $total_count ] && [ $total_count -gt 0 ]; then
        echo ""
        echo "🎉 All features complete! Website ready for launch."
    fi
}

start_feature() {
    feature="$1"
    feature_dir="$FEATURES_DIR/$feature"

    if [ ! -d "$feature_dir" ]; then
        echo "❌ Feature '$feature' not found"
        echo "   Available features:"
        ls -d "$FEATURES_DIR"/*/ 2>/dev/null | xargs -I {} basename {} | sed 's/^/   - /'
        exit 1
    fi

    startup_script="$feature_dir/startup.sh"

    if [ ! -f "$startup_script" ]; then
        echo "❌ Startup script not found: $startup_script"
        exit 1
    fi

    if [ ! -x "$startup_script" ]; then
        echo "⚠️  Startup script not executable. Fixing permissions..."
        chmod +x "$startup_script"
    fi

    echo "🚀 Starting feature: $feature"
    echo "=============================="

    # Run the startup script
    cd "$feature_dir"
    ./startup.sh
    cd - > /dev/null

    echo ""
    echo "✅ Feature '$feature' startup complete!"
    echo "   Next: Implement the feature following the instructions"
    echo "   Then run: $0 finalize $feature"
}

finalize_feature() {
    feature="$1"
    feature_dir="$FEATURES_DIR/$feature"

    if [ ! -d "$feature_dir" ]; then
        echo "❌ Feature '$feature' not found"
        echo "   Available features:"
        ls -d "$FEATURES_DIR"/*/ 2>/dev/null | xargs -I {} basename {} | sed 's/^/   - /'
        exit 1
    fi

    final_script="$feature_dir/final.sh"

    if [ ! -f "$final_script" ]; then
        echo "❌ Finalization script not found: $final_script"
        exit 1
    fi

    if [ ! -x "$final_script" ]; then
        echo "⚠️  Finalization script not executable. Fixing permissions..."
        chmod +x "$final_script"
    fi

    echo "🎉 Finalizing feature: $feature"
    echo "================================"

    # Run the final script
    cd "$feature_dir"
    ./final.sh
    cd - > /dev/null

    echo ""
    echo "✅ Feature '$feature' finalized!"
    echo "   Completion marker created: .${feature}-complete"
}

show_info() {
    feature="$1"
    feature_dir="$FEATURES_DIR/$feature"

    if [ ! -d "$feature_dir" ]; then
        echo "❌ Feature '$feature' not found"
        echo "   Available features:"
        ls -d "$FEATURES_DIR"/*/ 2>/dev/null | xargs -I {} basename {} | sed 's/^/   - /'
        exit 1
    fi

    echo "📋 Feature: $feature"
    echo "==================="
    echo ""

    # Show context.md if exists
    if [ -f "$feature_dir/context.md" ]; then
        cat "$feature_dir/context.md"
    else
        echo "No context documentation found."
    fi

    echo ""
    echo "📁 Files in feature directory:"
    ls -la "$feature_dir/"

    echo ""
    echo "⚡ Available scripts:"
    if [ -f "$feature_dir/startup.sh" ]; then
        echo "   ./startup.sh - Setup the feature"
    fi
    if [ -f "$feature_dir/final.sh" ]; then
        echo "   ./final.sh - Finalize and validate"
    fi

    # Check completion status
    if [ -f ".${feature}-complete" ]; then
        echo ""
        echo "✅ Status: COMPLETE"
        echo "   Completion report: .${feature}-complete"
    else
        echo ""
        echo "🟡 Status: IN PROGRESS"
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

command="$1"
feature="$2"

case "$command" in
    list)
        list_features
        ;;
    status)
        show_status
        ;;
    start)
        if [ -z "$feature" ]; then
            echo "❌ Please specify a feature to start"
            echo "   Usage: $0 start [feature]"
            echo ""
            list_features
            exit 1
        fi
        start_feature "$feature"
        ;;
    finalize)
        if [ -z "$feature" ]; then
            echo "❌ Please specify a feature to finalize"
            echo "   Usage: $0 finalize [feature]"
            echo ""
            list_features
            exit 1
        fi
        finalize_feature "$feature"
        ;;
    info)
        if [ -z "$feature" ]; then
            echo "❌ Please specify a feature for info"
            echo "   Usage: $0 info [feature]"
            echo ""
            list_features
            exit 1
        fi
        show_info "$feature"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "❌ Unknown command: $command"
        show_help
        exit 1
        ;;
esac