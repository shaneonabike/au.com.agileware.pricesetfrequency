{literal}
    <style>
        .crm-container span.description {
            display: block;
        }
    </style>
{/literal}

<div class="crm-price-field-form-block-recurring-contribution-unit">
    <div class="label"><label for="recurring_contribution_unit">  {ts}Recurring Contribution Unit{/ts}</label></div>
    <div>
        {$form.recurring_contribution_unit.html}
        <span class="description">
            {ts}Select individual recurring contribution unit.{/ts}
        </span>
    </div>
</div>

<div class="crm-price-field-form-block-recurring-contribution-interval" style="display: none;">
    <div class="label"><label for="recurring_contribution_interval">  {ts}Recurring Contribution Interval{/ts}</label></div>
    <div>
        {$form.recurring_contribution_interval.html}
        <span class="description">
            {ts}Individual recurring contribution interval{/ts}
        </span>
    </div>
</div>

<div class="crm-price-field-form-block-individual-contribution-source">
    <div class="label"><label for="individual_contribution_source">  {ts}Contribution Source{/ts}</label></div>
    <div>
        {$form.individual_contribution_source.html}
    </div>
</div>

<div class="price_field_extra_options" style="display: none;">
    {section name=rowLoop start=1 loop=16}
        {assign var=index value=$smarty.section.rowLoop.index}

        <div class="price_field_option_extra_{$index}">
            <div class="price_field_option_recur_contribution_unit">
                {$form.option_recurring_contribution_unit.$index.html}
            </div>
            <div class="price_field_option_recur_contribution_interval">
                {$form.option_recurring_contribution_interval.$index.html}
            </div>
            <div class="price_field_option_recur_contribution_source">
                {$form.option_individual_contribution_source.$index.html}
            </div>
        </div>
    {/section}
</div>

{literal}
<script type="text/javascript">

    if (cj('#optionField').size() > 0) {
        cj('#optionField tbody tr:first-child').append('<th>Recurring Contribution Unit</th>');
        cj('#optionField tbody tr:first-child').append('<th>Recurring Contribution Interval</th>');
        cj('#optionField tbody tr:first-child').append('<th>Contribution Source</th>');

        cj('#optionField tbody tr').each(function(index){

            var unitCell = cj('<td>');
            var intervalCell = cj('<td>');
            var sourceCell = cj('<td>');

            unitCell.html(cj('.price_field_option_extra_' + index).find('.price_field_option_recur_contribution_unit').html());
            intervalCell.html(cj('.price_field_option_extra_' + index).find('.price_field_option_recur_contribution_interval').html());
            intervalCell.find('input').hide();
            sourceCell.html(cj('.price_field_option_extra_' + index).find('.price_field_option_recur_contribution_source').html());

            if (index != 0) {
                cj(this).append(unitCell);
                cj(this).append(intervalCell);
                cj(this).append(sourceCell);
            }
        });
    }

    cj('.price_field_extra_options').remove();

    var classesToShift = [
        '.crm-price-field-form-block-recurring-contribution-unit',
        '.crm-price-field-form-block-recurring-contribution-interval',
        '.crm-price-field-form-block-individual-contribution-source',
    ];
    var insertAfterClass = '.crm-price-field-form-block-price';

    if (cj('.crm-price-option-form-block-amount').size() > 0) {
        insertAfterClass = '.crm-price-option-form-block-amount';
    }

    cj('body').on('change', 'select[name="recurring_contribution_unit"]', function(e){
       if (cj(this).val() != '') {
           cj('.crm-price-field-form-block-recurring-contribution-interval').show();
       }
       else{
           cj('.crm-price-field-form-block-recurring-contribution-interval').hide();
       }
    });

    cj('body').on('change', 'select[name^="option_recurring_contribution_unit"]', function(e){
        if (cj(this).val() != '') {
            cj(this).parent().parent().find('input[name^="option_recurring_contribution_interval"]').show();
        }
        else{
            cj(this).parent().parent().find('input[name^="option_recurring_contribution_interval"]').hide();
        }
    });

    for (var i = 0; i < classesToShift.length; i++) {
        var inConClass = classesToShift[i];
        cj(inConClass).insertAfter(insertAfterClass);
        insertAfterClass = inConClass;
        var existingHTML = cj(inConClass).html();
        existingHTML = existingHTML.replace(/<div/g,"<td");
        existingHTML = existingHTML.replace(/<\/div>/g,"</td>");
        var classToAdd = inConClass.substr(1);
        var stylesToAdd = "";
        if (classToAdd == 'crm-price-field-form-block-recurring-contribution-interval') {
            stylesToAdd = 'display: none';
        }
        cj(inConClass).replaceWith('<tr class="'+classToAdd+'" style="'+stylesToAdd+'">' + existingHTML + '</tr>');
    }

    if (cj('select[name="recurring_contribution_unit"]').val() != '') {
        cj('.crm-price-field-form-block-recurring-contribution-interval').show();
    }

</script>
{/literal}