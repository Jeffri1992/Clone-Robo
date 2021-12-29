#!/usr/bin/env groovy

def successNotification(webhook_id_success, teams_id_success, artifact_url, image_url_success, tag_name, message) {
    def job_link = "${BUILD_URL}" - 'http://10.54.4.11:28080/'
    job_link = 'https://deploykid.kompas.id/' + job_link
		sh """curl --location --request POST "https://kompas365.webhook.office.com/webhookb2/${webhook_id_success}/IncomingWebhook/${teams_id_success}" --header 'Content-Type: application/json' --data-raw '{
        "type": "message",
        "attachments": [
            {
            "contentType": "application/vnd.microsoft.card.adaptive",
            "contentUrl": null,
            "content": {
                "msteams": {
                "width": "Full"
                },
                "\$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "type": "AdaptiveCard",
                "version": "1.2",
                "body": [
                {
                    "type": "Container",
                    "items": [
                    {
                        "type": "ColumnSet",
                        "columns": [
                        {
                            "type": "Column",
                            "width": "auto",
                            "items": [
                            {
                                "type": "Image",
                                "url": "${image_url_success}",
                                "size": "medium",
                                "style": "person"
                            }
                            ]
                        },
                        {
                            "type": "Column",
                            "width": "stretch",
                            "items": [
                            {
                                "type": "TextBlock",
                                "text": "SUCCESS! Robot Test on ${message} ${tag_name}",
                                "weight": "bolder",
                                "wrap": true
                            }
                            ]
                        }
                        ]
                    }
                    ]
                },
                {
                    "type": "Container",
                    "items": [
                    {
                        "type": "TextBlock",
                        "text": "Hari Ini Anda Beruntung. \n  \n  \n  Anda Bisa bersantai sejenak. \n- Automation Branch: $BRANCH\n- Build URL: [$BUILD_NUMBER]($job_link)\n- Build Report: [REPORT]($artifact_url)\n\n
                                \n \n Result : $currentBuild.currentResult \n \n \n Duration : $currentBuild.durationString",
                        "wrap": true
                    }
                    ]
                }
                ]
            }
            }
        ]
		}'"""
}
def failedNotification(webhook_id_failed, teams_id_failed, artifact_url, image_url_failed, tag_name, message) {
    def job_links = "${BUILD_URL}" - 'http://10.54.4.11:28080/'
    job_links = 'https://deploykid.kompas.id/' + job_links
		sh """curl --location --request POST "https://kompas365.webhook.office.com/webhookb2/${webhook_id_failed}/IncomingWebhook/${teams_id_failed}" --header 'Content-Type: application/json' --data-raw '{
			"type": "message",
			"attachments": [
				{
				"contentType": "application/vnd.microsoft.card.adaptive",
				"contentUrl": null,
				"content": {
					"msteams": {
					"width": "Full"
					},
					"\$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
					"type": "AdaptiveCard",
					"version": "1.2",
					"body": [
					{
						"type": "Container",
						"items": [
						{
							"type": "ColumnSet",
							"columns": [
							{
								"type": "Column",
								"width": "auto",
								"items": [
								{
									"type": "Image",
									"url": "${image_url_failed}",
									"size": "medium",
									"style": "person"
								}
								]
							},
							{
								"type": "Column",
								"width": "stretch",
								"items": [
								{
									"type": "TextBlock",
									"text": "FAILED GUYS! Robot Test on ${message} ${tag_name}",
									"weight": "bolder",
									"wrap": true
								}
								]
							}
							]
						}
						]
					},
					{
						"type": "Container",
						"items": [
						{
							"type": "TextBlock",
							"text": "Tetap Tenang , Tetap Semangat  !!  \n  \n  \n  Ini hanya Ujian. \n- Automation Branch: $BRANCH\n- Build URL: [$BUILD_NUMBER]($job_links)\n- Build Report: [REPORT]($artifact_url)\n\n
									\n \n Result : $currentBuild.currentResult \n \n \n Duration : $currentBuild.durationString",
							"wrap": true
						}
						]
					}
					]
				}
				}
			]
		}'"""
}

return this
